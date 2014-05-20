PREFIX= /opt

#DEBUG= --dry-run
DEBUG=
VERBOSE= --verbose --progress --stats
DELETE= --delete-excluded --delete-after
V6="-6"
#LIMIT=--bwlimit=800
LIMIT=--bwlimit=3000

.PHONY: distrib debian-all fedora-all mandriva-all ubuntu-all
.PHONY: fedora fedora-livna fedora-rpmfusion

# http://fedoraproject.org/wiki/Infrastructure/Mirroring
RSYNC = \
	--archive \
	--hard-links \
	--human-readable \
	--numeric-ids \
	--prune-empty-dirs \
	${DELETE} \
	${VERBOSE} \
	${DEBUG} \
	${LIMIT} \

DEBIAN_EXCLUDES= \
	--exclude '*alpha.deb' \
	--exclude '*alpha.udeb' \
	--exclude 'binary-alpha' \
	--exclude 'installer-alpha' \
	--exclude 'Contents-alpha*' \
	--exclude '*arm*' \
	--exclude '*hppa*' \
	--exclude '*ia64*' \
	--exclude '*mips*' \
	--exclude '*powerpc*' \
	--exclude '*s390*' \
	--exclude '*sparc*' \
	--exclude '*sparc.udeb' \
	--exclude '*kfreebsd-*.deb' \
	--exclude '*kfreebsd-*.udeb' \
	--exclude 'binary-kfreebsd*' \
	--exclude 'Contents-kfreebsd*' \
	--exclude '*hurd-*.deb' \
	--exclude '*hurd-*.udeb' \
	--exclude 'binary-hurd*' \
	--exclude 'Contents-hurd*' \
	--exclude '*.dsc' \
	--exclude '*.diff.gz' \
	--exclude '*.orig.tar.gz' \
	--exclude '*experimental*' \
	--exclude 'installer*' \

UBUNTU_EXCLUDES= \
	--exclude '*.dsc' \
	--exclude '*.diff.gz' \
	--exclude '*.orig.tar.gz' \
	--exclude '*.diff.tar.gz' \
	--exclude '*.diff.bz2' \
	--exclude '*.diff.tar.bz2' \
	--exclude '*.orig.tar.bz2' \
	--exclude '*.~tmp~' \
	--exclude '*ps3*' \

FEDORA_UPDATES_EXCLUDES= \
	--exclude '1' \
	--exclude '2' \
	--exclude '3' \
	--exclude '4' \
	--exclude '5' \
	--exclude '6' \
	--exclude '7' \
	--exclude '8' \
	--exclude '9' \
	--exclude '10' \
	--exclude '11' \
	--exclude '12' \
	--exclude '13' \
	--exclude '14' \
	--exclude '15' \
	--exclude '16' \
	--exclude '17' \
	--exclude '18' \
	--exclude 'core' \
	--exclude 'redhat' \
	--exclude 'extras' \
	--exclude 'debug' \
	--exclude 'development' \
	--exclude 'source' \
	--exclude 'testing' \
	--exclude 'test' \
	--exclude 'SRPMS' \
	--exclude 'SRPMS.newkey' \
	--exclude '.~tmp~' \
	--exclude 'drpms' \
	--exclude 'iso' \
	--exclude 'Live' \

FEDORA_EXCLUDES= \
	--exclude '1' \
	--exclude '2' \
	--exclude '3' \
	--exclude '4' \
	--exclude '5' \
	--exclude '6' \
	--exclude '7' \
	--exclude '8' \
	--exclude '9' \
	--exclude '10' \
	--exclude '11' \
	--exclude '12' \
	--exclude '13' \
	--exclude '14' \
	--exclude '15' \
	--exclude '16' \
	--exclude '17' \
	--exclude '18' \
	--exclude 'core' \
	--exclude 'redhat' \
	--exclude 'extras' \
	--exclude 'debug' \
	--exclude 'development' \
	--exclude 'source' \
	--exclude 'testing' \
	--exclude 'test' \
	--exclude 'SRPMS' \
	--exclude 'SRPMS.newkey' \
	--exclude '.~tmp~' \
	--exclude 'drpms' \
	--exclude 'iso' \
	--exclude 'Live' \


MAGEIA_EXCLUDES= \
	--exclude 'iso' \
	--exclude 'people' \
	--exclude 'software' \
	--exclude 'distrib/1*' \
	--exclude 'distrib/2*' \


all: distrib iso
distrib: debian-all fedora-all mandriva-all ubuntu-all 
iso: debian-iso-all fedora-iso-all mageia-iso-all mandriva-iso-all ubuntu-iso-all 

.PHONY: sysresccd-iso
sysresccd-iso:
	/opt/scripts/find_iso_and_mount_it.sh /opt/tftp/sysresccd /opt/www/iso/sysresccd
	bash /opt/scripts/generate_pxe_for_sysresccd_isos.sh

.PHONY: debian-all
debian-all: debian debian-security debian-multimedia \
	debian-volatile debian-backports

.PHONY: debian
debian: debian-first-step debian-second-step

.PHONY: debian-first-step
debian-first-step :
	mkdir -p ${PREFIX}/www/debian/debian
	nice -n19 ionice -c 3 rsync ${RSYNC} ${DEBUG} ${LIMIT} \
	ftp.fr.debian.org::debian \
	${PREFIX}/www/debian/debian \
	${DEBIAN_EXCLUDES} \
	--exclude '*iso' \
        --exclude Packages* \
        --exclude Sources* \
        --exclude Release* \
        --exclude InRelease \
        --exclude i18n/* \

.PHONY: debian-second-step
debian-second-step :
	mkdir -p ${PREFIX}/www/debian/debian
	nice -n19 ionice -c 3 rsync ${RSYNC} ${DEBUG} ${LIMIT} \
	ftp.fr.debian.org::debian \
	${PREFIX}/www/debian/debian \
	${DEBIAN_EXCLUDES} \
	--exclude '*iso' \

.PHONY: debian-security
debian-security:
	mkdir -p ${PREFIX}/www/debian/debian-security
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	security.debian.org::debian-security \
	${PREFIX}/www/debian/debian-security \
	${DEBIAN_EXCLUDES}

# http://www.debian-multimedia.org/debian-m-rsync.php
.PHONY: debian-multimedia
debian-multimedia:
	mkdir -p ${PREFIX}/www/debian/debian-multimedia
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	mirror.home-dn.net::debian-multimedia \
	${PREFIX}/www/debian/debian-multimedia \
	${DEBIAN_EXCLUDES}

.PHONY: debian-volatile
debian-volatile:
	mkdir -p ${PREFIX}/www/debian/debian-volatile
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	ftp.uk.debian.org::debian-volatile \
	${PREFIX}/www/debian/debian-volatile \
	${DEBIAN_EXCLUDES}

.PHONY: debian-backports
debian-backports:
	mkdir -p ${PREFIX}/www/debian/debian-backports
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	ftp.nl.debian.org::backports.org \
	${PREFIX}/www/debian/debian-backports \
	${DEBIAN_EXCLUDES}

.PHONY: debian-iso-all
debian-iso-all:	debian-iso update-pxe-debian

#	ftp.de.debian.org::debian-cd 
#	ftp.proxad.net::mirrors/cdimage.debian.org/debian-cd
.PHONY: debian-iso
debian-iso:
	mkdir -p ${PREFIX}/www/iso/debian
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	ftp.de.debian.org::debian-cd \
	${PREFIX}/www/iso/debian \
	--exclude '*/source/*' \
	--include 'iso-cd/*-CD-1.iso' \
	--include 'iso-cd/*netinst.iso' \
	--include 'iso-cd/*businesscard.iso' \
	--include 'iso-cd/*SUMS*' \
	--exclude '*iso-dvd*' \
	--exclude '*CD-2*' \
	--exclude '*CD-3*' \
	--exclude '*CD-4*' \
	--exclude '*CD-5*' \
	--exclude '*CD-6*' \
	--exclude '*CD-7*' \
	--exclude '*CD-8*' \
	--exclude '*DVD*' \
	--exclude '*mips*' \
	--exclude '*powerpc*' \
	--exclude '*sparc*' \
	--exclude '*aspel*' \
	--exclude '*arm*' \
	--exclude '*ia64*' \
	--exclude '*s390*' \
	--exclude '*rescue*' \
	--exclude '*source*' \
	--exclude '*freebsd*' \
	--exclude '*iso-hybrid*'   
	/opt/scripts/find_iso_and_mount_it.sh /opt/tftp/debian/ /opt/www/iso/debian/

.PHONY: update-pxe-debian
update-pxe-debian:
	bash /opt/scripts/generate_pxe_for_debian_isos.sh

.PHONY: ubuntu-all
ubuntu-all: ubuntu-first-step ubuntu-second-step medibuntu

#	ftp.free.org::ubuntu  \
.PHONY: ubuntu-first-step
ubuntu-first-step:
	mkdir -p ${PREFIX}/www/ubuntu/ubuntu
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	rsync://archive.ubuntu.com/ubuntu  \
	${PREFIX}/www/ubuntu/ubuntu \
        --exclude "Sources*" \
	--exclude "Release*" \
	${UBUNTU_EXCLUDES} \
	--exclude '*iso' \

.PHONY: ubuntu-second-step
ubuntu-second-step:
	mkdir -p ${PREFIX}/www/ubuntu/ubuntu
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	rsync://archive.ubuntu.com/ubuntu  \
	${PREFIX}/www/ubuntu/ubuntu \
	${UBUNTU_EXCLUDES} \
	--exclude '*iso' 
	bash /root/extract_ubuntu_repo_gz.sh

# ancienne adresse rsync
#	medibuntu@dunnewind.net::medibuntu \
.PHONY: medibuntu
medibuntu:
	mkdir -p ${PREFIX}/www/ubuntu/medibuntu
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	packages.medibuntu.org::medibuntu \
	${PREFIX}/www/ubuntu/medibuntu \
	${UBUNTU_EXCLUDES} \
	--exclude hardy \
	--exclude jaunty \
	--exclude karmic \
	--exclude maverick \
	--exclude natty \
	--exclude oneiric \
	--exclude quantal \
	--exclude morgue \

.PHONY: ubuntu-iso-all
ubuntu-iso-all:	ubuntu-iso lubuntu-iso-cdimage kubuntu-iso-cdimage xubuntu-iso-cdimage update-pxe-ubuntu

.PHONY: ubuntu-iso
ubuntu-iso:
	#ftp.ciril.fr::pub/linux/ubuntu/releases/ \
	mkdir -p ${PREFIX}/www/iso/ubuntu/ubuntu
	nice -n19 ionice -c 3 rsync ${RSYNC} \
        -B 65536 \
	rsync://ftp.lip6.fr/Ubuntu/releases/ \
	${PREFIX}/www/iso/ubuntu/ubuntu \
	--exclude *6.06* \
	--exclude *8.04* \
	--exclude *8.10* \
	--exclude *9.04* \
	--exclude *9.10* \
	--exclude *10.04* \
	--exclude *10.11* \
	--exclude *11.04* \
	--exclude *11.10* \
	--exclude *12.10* \
	--exclude *13.04* \
	--exclude *dapper* \
	--exclude *edubuntu* \
	--exclude *hardy* \
	--exclude *intrepid* \
	--exclude *jaunty* \
	--exclude *karmic* \
	--exclude *lucid* \
	--exclude *maverick* \
	--exclude *natty* \
	--exclude *oneiric* \
	--exclude *beta* \
	--exclude *server*
	/opt/scripts/find_iso_and_mount_it.sh /opt/tftp/ubuntu-fr/ /opt/www/iso/ubuntu/francisees/
	/opt/scripts/find_iso_and_mount_it.sh /opt/tftp/ubuntu/ /opt/www/iso/ubuntu/ubuntu/

.PHONY: lubuntu-iso-cdimage
lubuntu-iso-cdimage:
	mkdir -p ${PREFIX}/www/iso/ubuntu/lubuntu
	nice -n19 ionice -c 3 rsync ${RSYNC} \
        -B 65536 \
	rsync://fr.cdimage.ubuntu.com/cdimage/lubuntu/ \
	${PREFIX}/www/iso/ubuntu/lubuntu \
	--exclude *daily* \
	--exclude '*powerpc*' \
	--exclude '*arm*' \
	--exclude *beta* \
	--exclude *6.06* \
	--exclude *8.04* \
	--exclude *8.10* \
	--exclude *9.04* \
	--exclude *9.10* \
	--exclude *10.04* \
	--exclude *10.11* \
	--exclude *11.04* \
	--exclude *11.10* \
	--exclude *12.10* \
	--exclude *13.04* \
        --no-checksum 
	/opt/scripts/find_iso_and_mount_it.sh /opt/tftp/lubuntu/ /opt/www/iso/ubuntu/lubuntu/

.PHONY: kubuntu-iso-cdimage
kubuntu-iso-cdimage:
	mkdir -p ${PREFIX}/www/iso/ubuntu/kubuntu
	nice -n19 ionice -c 3 rsync ${RSYNC} \
        -B 65536 \
	rsync://fr.cdimage.ubuntu.com/cdimage/kubuntu/ \
	${PREFIX}/www/iso/ubuntu/kubuntu \
	--exclude *daily* \
	--exclude '*powerpc*' \
	--exclude '*arm*' \
	--exclude '*dvd*' \
	--exclude *beta* \
	--exclude *6.06* \
	--exclude *8.04* \
	--exclude *8.10* \
	--exclude *9.04* \
	--exclude *9.10* \
	--exclude *10.04* \
	--exclude *10.11* \
	--exclude *11.04* \
	--exclude *11.10* \
	--exclude *12.10* \
	--exclude *13.04* \
        --no-checksum 
	/opt/scripts/find_iso_and_mount_it.sh /opt/tftp/kubuntu/ /opt/www/iso/ubuntu/kubuntu/

.PHONY: xubuntu-iso-cdimage
xubuntu-iso-cdimage:
	mkdir -p ${PREFIX}/www/iso/ubuntu/xubuntu
	nice -n19 ionice -c 3 rsync ${RSYNC} \
        -B 65536 \
	rsync://fr.cdimage.ubuntu.com/cdimage/xubuntu/ \
	${PREFIX}/www/iso/ubuntu/xubuntu \
	--exclude *daily* \
	--exclude '*powerpc*' \
	--exclude '*arm*' \
	--exclude *beta* \
	--exclude *6.06* \
	--exclude *8.04* \
	--exclude *8.10* \
	--exclude *9.04* \
	--exclude *9.10* \
	--exclude *10.04* \
	--exclude *10.11* \
	--exclude *11.04* \
	--exclude *11.10* \
	--exclude *12.10* \
	--exclude *13.04* \
        --no-checksum 
	/opt/scripts/find_iso_and_mount_it.sh /opt/tftp/xubuntu/ /opt/www/iso/ubuntu/xubuntu/

.PHONY: update-pxe-ubuntu
update-pxe-ubuntu:
	bash /opt/scripts/generate_pxe_for_ubuntu_isos.sh

.PHONY: fedora-all
fedora-all: fedora fedora-updates fedora-rpmfusion

# fedora-livna n'est pas indispensable, et ne marche pas pour l'instant
.PHONY: fedora-really-all
fedora-all: fedora-all fedora-livna

# http://mirrors.fedoraproject.org/publiclist/
# 	rsync://ftp-stud.hs-esslingen.de/fedora/linux \

.PHONY: fedora
fedora:
	mkdir -p ${PREFIX}/www/fedora/fedora
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	rsync://mirrors.ircam.fr/fedora-linux/releases \
	${PREFIX}/www/fedora/releases \
	${FEDORA_EXCLUDES}

.PHONY: fedora-updates
fedora-updates:
	mkdir -p ${PREFIX}/www/fedora/fedora
	nice -n19 ionice -c 3 rsync ${RSYNC} \
	rsync://mirrors.ircam.fr/fedora-linux/updates \
	${PREFIX}/www/fedora/updates \
	${FEDORA_UPDATES_EXCLUDES}

# Dépôt pour libdvdcss
.PHONY: fedora-livna
fedora-livna:
	mkdir -p ${PREFIX}/www/fedora/livna
	rsync ${RSYNC} \
	ftp-stud.fht-esslingen.de/pub/Mirrors/rpm.livna.org/::rlo \
	${PREFIX}/www/fedora/livna \
	${FEDORA_EXCLUDES}

.PHONY: fedora-rpmfusion
fedora-rpmfusion:
	mkdir -p ${PREFIX}/www/fedora/rpmfusion
	rsync ${RSYNC} \
	fr2.rpmfind.net::linux/rpmfusion/ \
	${PREFIX}/www/fedora/rpmfusion \
	${FEDORA_EXCLUDES}

.PHONY: fedora-iso-all
fedora-iso-all:	fedora-iso fedora-iso-alt

.PHONY: fedora-iso
fedora-iso:
	mkdir -p ${PREFIX}/www/iso/fedora/fedora
	rsync ${RSYNC} \
	ftp.ciril.fr::fedora \
	${PREFIX}/www/iso/fedora/fedora \
	--exclude '9' \
	--exclude '10' \
	--exclude '11' \
	--exclude '12' \
	--exclude '13' \
	--exclude '14' \
	--exclude '15' \
	--exclude '16' \
	--exclude '17' \
	--exclude '18' \
	--exclude 'development' \
	--exclude 'source' \
	--exclude 'test' \
	--include '*/' \
	--include 'iso/***' \
	--include 'Live/***' \
	--include 'img/***' \
	--exclude '*' 
	/opt/scripts/find_iso_and_mount_it.sh /opt/tftp/fedora/ /opt/www/iso/fedora/fedora/

.PHONY: fedora-iso-alt
fedora-iso-alt:
	mkdir -p ${PREFIX}/www/iso/fedora/alt
	rsync ${RSYNC} \
	alt.fedoraproject.org::alt \
	${PREFIX}/www/iso/fedora/alt \
	--exclude ltsp \
	--exclude nightly-composes \
	--exclude S390 \
	--exclude videos 


#.PHONY: mandriva-all
#mandriva-all:	mandriva mandriva-plf
#
#.PHONY: mandriva
#mandriva:
#	mkdir -p ${PREFIX}/www/mandriva/mandriva
#	rsync ${RSYNC} \
#	distrib-coffee.ipsl.jussieu.fr::mandrivalinux \
#	${PREFIX}/www/mandriva/mandriva \
#	--exclude iso \
#	${MANDRIVA_EXCLUDES}
#
#.PHONY: mandriva-plf
#mandriva-plf:
#	mkdir -p ${PREFIX}/www/mandriva/plf
#	rsync ${RSYNC} \
#	distrib-coffee.ipsl.jussieu.fr::plf \
#	${PREFIX}/www/mandriva/plf \
#	${MANDRIVA_EXCLUDES}
#
#.PHONY: mandriva-iso-all
#mandriva-iso-all:	mandriva-iso
#
#.PHONY: mandriva-iso
#mandriva-iso:
#	mkdir -p ${PREFIX}/www/iso/mandriva
#	rsync ${RSYNC} \
#	distrib-coffee.ipsl.jussieu.fr::mandrivalinux/official/iso/ \
#	${PREFIX}/www/iso/mandriva \
#	--include */ \
#	--include 2010.2/** \
#	--exclude * \


.PHONY: mageia-all
mageia-all:	mageia

.PHONY: mageia
mageia:
	mkdir -p ${PREFIX}/www/mageia
	rsync ${RSYNC} \
	distrib-coffee.ipsl.jussieu.fr::mageia \
	${PREFIX}/www/mageia \
	${MAGEIA_EXCLUDES}

.PHONY: mageia-iso-all
mageia-iso-all:		mageia-iso

.PHONY: mageia-iso
mageia-iso:
	mkdir -p ${PREFIX}/www/iso/mageia
	rsync ${RSYNC} \
	distrib-coffee.ipsl.jussieu.fr::mageia/iso/ \
	${PREFIX}/www/iso/mageia \
	--exclude '1/*' \
	--exclude '2/*' 


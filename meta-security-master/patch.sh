#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
set -x

git checkout conf/layer.conf
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0001-layer.conf-whinlatter.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0001-layer.conf-whinlatter.patch
fi

git checkout dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0002-checksecurity-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0002-checksecurity-new-syntax.patch
fi

git checkout dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0003-bastille-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0003-bastille-new-syntax.patch
fi

git checkout dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0004-nikto-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0004-nikto-new-syntax.patch
fi

git checkout dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0005-python3-json2html-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0005-python3-json2html-new-syntax.patch
fi

git checkout dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.7.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0006-python3-xmldiff-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0006-python3-xmldiff-new-syntax.patch
fi

# upstream?
git checkout dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0007-python3-yamlpath-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0007-python3-yamlpath-new-syntax.patch
fi

git checkout dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0008-python3-fail2ban-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0008-python3-fail2ban-new-syntax.patch
#fi

# upstream?
git checkout meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0009-systemd-boot_-.bbappend-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0009-systemd-boot_-.bbappend-new-syntax.patch
fi

# upstream?
git checkout meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0010-swtpm-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0010-swtpm-new-syntax.patch
fi

# upstream?
git checkout meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0011-tpm2-abrmd-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0011-tpm2-abrmd-new-syntax.patch
fi

git checkout recipes-compliance/openscap/openscap_1.4.1.bb
ls recipes-compliance/openscap/openscap_1.4.1.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0012-openscap-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0012-openscap-new-syntax.patch
#fi


git checkout recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb 
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0013-scap-security-guide-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0013-scap-security-guide-new-syntax.patch
#fi

git checkout recipes-core/packagegroup/packagegroup-core-security.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0014-packagegroup-core-security-removed-ossec-hids-needs-.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0014-packagegroup-core-security-removed-ossec-hids-needs-.patch
fi

git checkout recipes-ids/aide/aide_0.18.8.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0015-aide-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0015-aide-new-syntax.patch
fi

git checkout recipes-ids/ossec/ossec-hids_3.7.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0016-ossec-hids-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0016-ossec-hids-new-syntax.patch
fi

git checkout recipes-ids/suricata/files/fixup.patch
git checkout recipes-ids/suricata/libhtp_0.5.50.bb
git checkout recipes-ids/suricata/suricata_7.0.0.bb
mv recipes-ids/suricata/suricata_7.0.0.bb recipes-ids/suricata/suricata_7.0.10.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0017-suricata-7.0.0-7.0.10-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0017-suricata-7.0.0-7.0.10-new-syntax.patch
fi

git checkout recipes-ids/tripwire/tripwire_2.4.3.7.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0018-tripwire-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0018-tripwire-new-syntax.patch
fi


git checkout recipes-kernel/lkrg/lkrg-module_0.9.7.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0019-lkrg-module-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0019-lkrg-module-new-syntax.patch
fi

git checkout recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0020-ccs-tools-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0020-ccs-tools-new-syntax.patch
fi

git checkout recipes-mac/smack/smack_1.3.1.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0021-smack-use-CVE_STATUS.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0021-smack-use-CVE_STATUS.patch
fi

git checkout recipes-perl/perl/libwhisker2-perl_2.5.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0022-libwhisker2-perl-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0022-libwhisker2-perl-new-syntax.patch
fi

git checkout recipes-scanners/checksec/checksec_2.6.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0023-checksec-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0023-checksec-new-syntax.patch
fi

git checkout recipes-scanners/clamav/clamav_0.104.4.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0024-clamav-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0024-clamav-new-syntax.patch
#fi

git checkout  recipes-scanners/rootkits/chkrootkit_0.58b.bb
rm -f recipes-scanners/rootkits/files/0001-make-it-build-with-gcc-15.patch
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0025-chkrootkit-make-it-build-with-gcc-15.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0025-chkrootkit-make-it-build-with-gcc-15.patch
fi

git checkout recipes-security/cryptmount/cryptmount_6.2.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0026-cryptmount-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0026-cryptmount-new-syntax.patch
fi

git checkout recipes-security/fscryptctl/fscryptctl_1.1.0.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0027-fscryptctl-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0027-fscryptctl-new-syntax.patch
#fi

git checkout recipes-security/glome/glome_git.bb
#if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0028-glome-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0028-glome-new-syntax.patch
#fi

git checkout recipes-security/isic/isic_0.07.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0029-isic-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0029-isic-new-syntax.patch
fi

git checkout recipes-security/redhat-security/redhat-security_1.0.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0030-redhat-security-new-syntax.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0030-redhat-security-new-syntax.patch
fi

git checkout recipes-security/sshguard/sshguard_2.4.3.bb
rm -f recipes-security/sshguard/sshguard_2.5.1.bb
if ! patch -R -p1 -s -f --dry-run <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0031-sshguard-2.4.3-2.5.1.patch; then
     patch -p1 <${SCRIPTPATH}/against-ebe9234fb8867d5be6916b52b54e24f191f5fcab/0031-sshguard-2.4.3-2.5.1.patch
fi

git diff --stat

git status

git add .
git commit -m "patch typically only against upstream master"
set +x

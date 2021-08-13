#!/bin/bash
###################################################
#
# BITS Reposync
# 
# reposync to [OS]-[architecture]/
# then createrepo.
#
# 2018MAR30 
#  -Initial creation
#  
# 2018APR02
#  -Resolved error with "for" loop
#
# 2018APR04
#  -Added CentOS 7 repositories
#
# 2018APR05
#  -Added Oracle Repositories
#
###################################################

##### Variables #####
repoDirectories=$(find  -mindepth 2 -maxdepth 2 -type d)
#LOG=${adddate /var/log/reposync.log}
REPOARGS="--config=/etc/reposync.conf -n --download-metadata --norepopath"
##### Functions #####

adddate() {
    while IFS= read -r line; do
        echo "$(date +%Y-%m-%dT%H:%M:%S%z) $line"
    done
}



##### Sync CentOS x86_64 and i686 repositories seperately ######

reposync $REPOARGS -r base-64 -p centos6-x86_64/base/ | adddate >> /var/log/reposync.log
reposync $REPOARGS -r updates-64 -p centos6-x86_64/updates/ | adddate /var/log/reposync.log
reposync $REPOARGS -r centosplus-64 -p centos6-x86_64/centosplus/ | adddate /var/log/reposync.log
reposync $REPOARGS -r extras-64 -p centos6-x86_64/extras/ | adddate >> /var/log/reposync.log
reposync $REPOARGS -r fasttrack-64 -p centos6-x86_64/fasttrack/ | adddate >> /var/log/reposync.log
reposync $REPOARGS -r base-i386 -p centos6-i686/base/ | adddate >> /var/log/reposync.log
reposync $REPOARGS -r updates-i386 -p centos6-i686/updates/ | adddate >> /var/log/reposync.log
reposync $REPOARGS -r centosplus-i386 -p centos6-i686/centosplus/ | adddate >> /var/log/reposync.log
reposync $REPOARGS -r extras-i386 -p centos6-i686/extras/ | adddate >> /var/log/reposync.log
reposync $REPOARGS -r fasttrack-i386 -p centos6-i686/fasttrack/ | adddate >> /var/log/reposync.log
reposync $REPOARGS -r epel-64 -p rhel6-server-x86_64/epel | adddate >> /var/log/reposync.log
reposync $REPOARGS -r epel-i386 -p rhel6-server-i686/epel | adddate >> /var/log/reposync.log

##### CentOS 7 #####

reposync $REPOARGS -r base-7 -p centos7-x86_64/base | adddate >> /var/log/reposync.log
reposync $REPOARGS -r updates-7 -p centos7-x86_64/updates | adddate >> /var/log/reposync.log
reposync $REPOARGS -r extras-7 -p centos7-x86_64/extras | adddate >> /var/log/reposync.log
reposync $REPOARGS -r centosplus-7 -p centos7-x86_64/centosplus | adddate >> /var/log/reposync.log
reposync $REPOARGS -r fasttrack-7 -p centos7-x86_64/fasttrack | adddate >> /var/log/reposync.log
reposync $REPOARGS -r epel-7 -p centos7-x86_64/epel | adddate >> /var/log/reposync.log

##### RHEL 6 and 7 #####

reposync $REPOARGS -r rhel-base-6 -p rhel6-server-x86_64/os | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-extras-6 -p rhel6-server-x86_64/extras | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-fastrack-6 -p rhel6-server-x86_64/fastrack | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-optional-6 -p rhel6-server-x86_64/optional | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-rhn-tools-6 -p rhel6-server-x86_64/rhn-tools | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-rhscl-6 -p rhel6-server-x86_64/rhscl | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-supplementary-6 -p rhel6-server-x86_64/supplementary | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-base-7 -p rhel7-server-x86_64/os | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-extras-7 -p rhel7-server-x86_64/extras | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-fastrack-7 -p rhel7-server-x86_64/fastrack | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-optional-7 -p rhel7-server-x86_64/optional | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-rhn-tools-7 -p rhel7-server-x86_64/rhn-tools | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-rhscl-7 -p rhel7-server-x86_64/rhscl | adddate >> /var/log/reposync.log
reposync $REPOARGS -r rhel-supplementary-7 -p rhel7-server-x86_64/supplementary | adddate >> /var/log
/reposync.log

##### Oracle Linux 6 #####

reposync $REPOARGS -r ol6_mysql57 -p ol6-x86_64/ol6_mysql57 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_uek_latest -p ol6-x86_64/ol6_uek_latest | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_spacewalk24_client -p ol6-x86_64/ol6_spacewalk24_client | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_spacewalk26_client -p ol6-x86_64/ol6_spacewalk26_client | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_spacewalk26_server -p ol6-x86_64/ol6_spacewalk26_server | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_ofed_uekr4 -p ol6-x86_64/ol6_ofed_uekr4 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_ga_base -p ol6-x86_64/ol6_ga_base | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_mysql56 -p ol6-x86_64/ol6_mysql56 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_ofed_uek -p ol6-x86_64/ol6_ofed_uek | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_uekr4 -p ol6-x86_64/ol6_uekr4 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_spacewalk24_server -p ol6-x86_64/ol6_spacewalk24_server | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_addons -p ol6-x86_64/ol6_addons | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_uekr3_latest -p ol6-x86_64/ol6_uekr3_latest | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_mysql -p ol6-x86_64/ol6_mysql | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_latest -p ol6-x86_64/ol6_latest | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol6_uek_base -p ol6-x86_64/ol6_uek_base | adddate >> /var/log/reposync.log

##### Oracle Linux 7 #####

reposync $REPOARGS -r ol7_latest -p ol7-x86_64/ol7_latest | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_softwarecollections -p ol7-x86_64/ol7_softwarecollections | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_optional_latest -p ol7-x86_64/ol7_optional_latest | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_mysql55 -p ol7-x86_64/ol7_mysql55 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_spacewalk24_client -p ol7-x86_64/ol7_spacewalk24_client | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_mysql56 -p ol7-x86_64/ol7_mysql56 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_uekr3 -p ol7-x86_64/ol7_uekr3 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_uekr4 -p ol7-x86_64/ol7_uekr4 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_addons -p ol7-x86_64/ol7_addons | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_uekr4_ofed -p ol7-x86_64/ol7_uekr4_ofed | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_uekr3_ofed20 -p ol7-x86_64/ol7_uekr3_ofed20 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_u0_base -p ol7-x86_64/ol7_u0_base | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_mysql57 -p ol7-x86_64/ol7_mysql57 | adddate >> /var/log/reposync.log
reposync $REPOARGS -r ol7_spacewalk24_server -p ol7-x86_64/ol7_spacewalk24_server | adddate >> /var/log/reposync.log


##### Make Repositories #####

for path in $repoDirectories; do
  cd $path
  if [[ -d repodata ]]; then
    createrepo -g `ls -1tr | grep comps.xml$ | tail -1` --workers 10 --update . | adddate >> /var/log/reposync.log
  else
    createrepo -g `ls -1tr | grep comps.xml$ | tail -1` --workers 10 . | adddate >> /var/log/reposync.log
  fi
  if [[ -e updateinfo.xml ]]; then
    gunzip `ls -tr *updateinfo.xml.gz | tail -1` | adddate >> /var/log/reposync.log
    mv `ls -tr *updateinfo.xml | tail -1` updateinfo.xml | adddate >> /var/log/reposync.log
    modifyrepo updateinfo.xml repodata/ | adddate >> /var/log/reposync.log
  fi
done

##### Make sure all files and directories #####
#####       have correct permissions	  #####

for varDirec in `find  -mindepth 2 -type d`; do
	chmod 755 $varDirec
done;
for varFiles in `find  -mindepth 2 -type f`; do
	chmod 644 $varFiles
done;

##### Bounce Apache #####

/etc/init.d/httpd restart | adddate >> /var/log/reposync.log || echo "httpdErr[$?]: FAILURE TO RESTART APACHE DAEMON" | adddate >> /var/log/reposync.log

##### Check if the repositories are available and correct #####

for i in `find /var/www/mirror -mindepth 2 -type d | sed 's|\/var\/www\/mirror\/||g' | grep repodata`; do
  curl --silent -k https://<site>.mil/mirror/$i/repomd.xml 2>&1 1>/dev/null || echo "CurlErr[$?]: UNABLE TO VERIFY REPOSITORY `echo $i | awk -F/ '{print $1"/"$2}'`" | adddate >> /var/log/reposync.log
done

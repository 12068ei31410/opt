#!/bin/bash

LATEST_VERS=`hammer content-view version list --content-view "RDT&E Core Services" --organization-label "RDT_E_Core_Services" | awk '{print $8}' | sort -nr | head -n1`

hammer content-view version promote --version $LATEST_VERS --content-view "RDT&E Core Services" --organization-label "RDT_E_Core_Services" --to-lifecycle-environment "RDT&E Core Services" --async

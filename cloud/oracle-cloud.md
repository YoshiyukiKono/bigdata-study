# Oracle Cloud

## Cloudera on Oracle Cloud

* Cloudera Enterprise Data Hub on Oracle Cloud Infrastructure
https://cloud.oracle.com/iaas/cloudera?source=:em:ip:ie:mt:StrataEU_BigdataScreen%20reader%20support%20enabled&utm_medium=email&utm_source=topic+optin&utm_campaign=awareness&utm_content=20190424+data+nl&mkt_tok=eyJpIjoiTXprNE9ESTBaR1ptTXpSbSIsInQiOiJpU0Iwd2h4dmlyR0RMRVdkbmVQSzZjNVFsSGtZT2F1ZzFlaDZhTTB0UDNsZThIRlNwY2FaREtlRWxNTUw1c3ZuOGw2YUNrdjlvXC8xR3hJVkhpUmNsU1wvWUdSWGhQS2hqMFhsVXdVTVwvQzg2R3RvRER0NjhXWTB6R3BGZjJiQ3ErciJ9

* Reference Architecture
https://cloud.oracle.com/iaas/whitepapers/cloudera_reference_arch_oci.pdf

S3 Compatible Adapterの記述はない。

* Terraform module to deploy Cloudera on Oracle Cloud Infrastructure (OCI)

https://github.com/oracle/oci-quickstart-cloudera

以下、上記URLからの引用

## Object Storage Integration
As of the 2.1.0 release, included with this template is a means to deploy clusters with configuration to allow use of OCI Object Storage using S3 Compatability.  In order to implement, an S3 Access and Secret key must be set up in the OCI Tenancy first.  This process is detailed [here](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcredentials.htm#Working2).  Once that is in place, modify the [deploy_on_oci.py](https://github.com/oracle/oci-quickstart-cloudera/blob/master/scripts/deploy_on_oci.py#L101-L108) script, and set the following values:

	s3_compat_enable = 'False'
	s3a_secret_key = 'None'
	s3a_access_key = 'None'
	s3a_endpoint = 'None'	

The first should be set to 'True', then replace 'None" with each of the required values.   This configuration will then be pushed as part of the cluster deployment.

## Deployment Syntax
Deployment of the module is straight forward using the following Terraform commands

	terraform init
	terraform plan
	terraform apply

This will create all the required elements in a compartment in the target OCI tenancy.  This includes VCN and Security List parameters.  Security audit of these in the [network module](https://github.com/oracle/oci-quickstart-cloudera/blob/master/terraform/modules/network/main.tf) is suggested.


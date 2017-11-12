# -*- mode: ruby -*-
# vi: set ft=ruby :
# Copyright 2013 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Usage:
#  1) Launch both instances and then destroy both
#     $ vagrant up --provider=google
#     $ vagrant destroy
#  2) Launch one instance 'instance_deb_1c' and then destory the same
#     $ vagrant up instance_deb_1c --provider=google
#     $ vagrant destroy instance_deb_1c

# Customize these global variables
$GOOGLE_PROJECT_ID = "gcs-bcn-training-1"
$GOOGLE_CLIENT_EMAIL = "vagrantdeploys@gcs-bcn-training-1.iam.gserviceaccount.com"
$GOOGLE_JSON_KEY_LOCATION = "~/.creds/gcs-bcn-training-1-credential.json"
$LOCAL_USER = "vmucuge"
$LOCAL_SSH_KEY = "~/.ssh/id_rsa"

Vagrant.configure("2") do |config|
  config.vm.box = "google/gce"
  #config.vm.provision :shell, :inline => $PROVISION_DEBIAN
  config.ssh.pty = false
  config.vm.boot_timeout = 20

  config.vm.define :instance_deb_1c do |instance_deb_1c|
    instance_deb_1c.vm.provider :google do |google, override|
      google.google_project_id = $GOOGLE_PROJECT_ID
      google.google_client_email = $GOOGLE_CLIENT_EMAIL
      google.google_json_key_location = $GOOGLE_JSON_KEY_LOCATION
      google.zone = "us-central1-c"

      override.ssh.username = $LOCAL_USER
      override.ssh.private_key_path = $LOCAL_SSH_KEY
      override.ssh.pty = false

      google.zone_config "us-central1-c" do |instance_deb_1c|
        instance_deb_1c.name = "instance-deb-1c"
        instance_deb_1c.image = "debian-9-stretch-v20171025"
        instance_deb_1c.machine_type = "n1-standard-1"
        instance_deb_1c.zone = "us-central1-c"
        instance_deb_1c.service_accounts = "$GOOGLE_CLIENT_EMAIL"
        instance_deb_1c.metadata = {'zone' => "US Central 1c", 'custom' => 'metadata', 'instancename' => 'instance-deb-1c', 'startup-script-url' => 'gs://gcs-startup-scripts/provision_deb.sh'}
        instance_deb_1c.scopes = ['devstorage.full_control', 'bigquery', 'monitoring', 'https://www.googleapis.com/auth/compute']
        instance_deb_1c.tags = ['allow-vgm', 'allow-sbt']
      end
    end
  end

  config.vm.define :instance_rh_1f do |instance_rh_1f|
    instance_rh_1f.vm.provider :google do |google, override|
      google.google_project_id = $GOOGLE_PROJECT_ID
      google.google_client_email = $GOOGLE_CLIENT_EMAIL
      google.google_json_key_location = $GOOGLE_JSON_KEY_LOCATION
      google.zone = "us-central1-f"

      override.ssh.username = $LOCAL_USER
      override.ssh.private_key_path = $LOCAL_SSH_KEY

      google.zone_config "us-central1-f" do |instance_rh_1f|
        instance_rh_1f.name = "instance-rh-1f"
        instance_rh_1f.image = "centos-7-v20171025"
        instance_rh_1f.machine_type = "n1-standard-1"
        instance_rh_1f.zone = "us-central1-f"
        instance_rh_1f.disk_size = "50"
        instance_rh_1f.service_accounts = "$GOOGLE_CLIENT_EMAIL"
        instance_rh_1f.metadata = {'zone' => "US Central 1f", 'custom' => 'metadata', 'instancename' => 'instance-rh-1f', 'startup-script-url' => 'gs://gcs-startup-scripts/provision_rpm.sh'}
        instance_rh_1f.scopes = ['devstorage.full_control', 'bigquery', 'monitoring', 'https://www.googleapis.com/auth/compute']
        instance_rh_1f.tags = ['allow-vgm', 'allow-sbt']
      end
    end
  end
end

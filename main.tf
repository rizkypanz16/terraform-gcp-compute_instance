provider "google" {
    credentials = file("<credentials_file.json>")							# rubah <credentials_file.json> dengan file credentials google yang anda miliki
    project     = "<project_id>"					        				# rubah <project_id> dengan google project_id yang anda miliki
    region      = "us-central1"							
    zone        = "us-central1-a"
}

resource "google_compute_instance" "node1" {
    count	 = 2															# jumlah instance yang akan dibuat
    name         = "node${count.index + 1}"									# nama instance
    machine_type = "e2-medium"				
    zone         = "us-central1-a"

    tags = ["node1", "http-server", "https-server"]							# firewall allow http, allow https

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-2204-lts"						# machine image
	    size  = 32															# instance boot_disk size
        }
    }
    # metadata_startup_script = "apt update -y && apt install -y nginx"		#startup script

    network_interface {
        network = "default"
        access_config {}        // enable public ip
    }
}


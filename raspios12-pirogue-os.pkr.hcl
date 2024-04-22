packer {
  required_plugins {
    arm-image = {
      version = ">= 0.2.5"
      source  = "github.com/solo-io/arm-image"
    }
  }
}


source "arm-image" "pirogue-os" {
  iso_checksum      = "sha256:58a3ec57402c86332e67789a6b8f149aeeb4e7bb0a16c9388a66ea6e07012e45"
  iso_url           = "https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2024-03-15/2024-03-15-raspios-bookworm-arm64-lite.img.xz"
}

build {
  source "source.arm-image.pirogue-os" {
    name = "pirogue-os"
  }

  provisioner "shell" {
    script = "./raspi-os-12/script.sh"
  }

  post-processor "shell-local" {
    script = "./raspi-os-12/post.sh"
    keep_input_artifact = true
  }
}

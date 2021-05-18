#!/usr/bin/env nextflow


directory = Channel.fromPath(params.file_path)

def helpMessage() {
  log.info """
    Usage:
    The typical command to run the pipeline is as follows:
    nextflow run main.nf --command YOUR_QUERY --outputName YOUR_OUTPUT_NAME --file THE_FILE_PATH

    Mandatory arguments:

    Optional arguments:

    --recette_in        The pipeline you want to be executed
    --outputName        Necessary to give the output name if the zip command. Image by default
    --file_path         The path of the file $PWD/Kubernetes_cluster_architecture.png by default

    """
}

if (params.help) {
  helpMessage()
  exit 0
}


process zipLocal{

  container 'klibr/ubuntu-zip:v1'

  input:
  path directory

  output:
  path "home/fileZipped/" into unzip_ch





  script:

    """
    #!/bin/bash

    set -e
    echo zip
    cd home/fileToZip
    zip image *
    mv image.zip ../fileZipped/

    """
}

process unzipLocal{

  container 'klibr/ubuntu-zip:v1'

  input:
  path unzip_ch

  script:


    """
    #!/bin/bash

    set -e
    echo unzip
    ls
    cd fileZipped
    unzip *.zip
    mv * ../fileUnzipped

    """

}

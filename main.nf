#!/usr/bin/env nextflow


recette = Channel.fromList(params.recette_in)
directory = Channel.fromPath("$PWD")

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


process zip{

  container 'klibr/ubuntu-zip:v1'

  input:
  val recette

  output:
  path "/home/fileZipped" into directory
  path "/home/fileUnzipped" into directory
  
  script:
  switch (recette){
    case 1:
    """
    #!/bin/bash

    cd /fileToZip
    zip image *
    mv image.zip /home/fileZipped

    """
    case 2:
    """
    #!/bin/bash

    cd /fileToUnzip
    unzip *.zip
    rm -r *.zip
    mv * /home/fileUnzipped

    """


  }
}

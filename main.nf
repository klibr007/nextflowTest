#!/usr/bin/env nextflow

#file_path = Channel.fromPath(params.file_path)
recette = Channel.fromList(params.recette_in)

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
  #path file_path
  val recette

  output:
  publishDir "$PWD/home/"
  path(/home/fileZipped)
  path(/home/fileUnzipped)
  
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

package com.github.shinkchu.pubmgr

import grails.transaction.Transactional

@Transactional
class FileUploadService {

  static transactional = false

  def grailsApplication

  def uploadFileToDataDir(def controllerName, def fileHandler, def tag=null) {
    def DATA_DIR_NAME = 'data'
    def UPLOAD_IN_DATA_DIR_NAME = 'upload'

    def partialName
    if (fileHandler != null && !fileHandler?.empty) {
      def filename = composeFilename(controllerName, fileHandler.originalFilename, null, tag)
      def fileRealPath = upload(fileHandler, DATA_DIR_NAME + "/" + UPLOAD_IN_DATA_DIR_NAME, filename)
      if (fileRealPath) {
        partialName = UPLOAD_IN_DATA_DIR_NAME + "/" + filename
      }
    }

    return partialName
  }
  def moveFileToDirInData(def controllerName, File file, def dstDirNameInData, def tag=null) {
    def DATA_DIR_NAME = 'data'
    def dataDirRealPath = grailsApplication.mainContext.servletContext.getRealPath(DATA_DIR_NAME)

    def dstDirRealPath = dataDirRealPath + "/" + dstDirNameInData
    def filename = composeFilename(controllerName, file.getName(), null, tag)

    if (file==null || !file.exists()) {
      return null
    } else {
      def dstDirFile = new File(dstDirRealPath)
      if (!dstDirFile.exists()) {
        dstDirFile.mkdirs()
      }

      if (dstDirFile.isDirectory()) {
        boolean fileMoved = file.renameTo(new File(dstDirRealPath, filename))
        if (fileMoved) {
          return dstDirNameInData + "/" + filename
        } else {
          return null
        }
      } else {
        return null
      }
    }
  }

  def static alphabet = (('A'..'Z')+('0'..'9')).join()
  def randomer = {int n ->
    new Random().with {
      (1..n).collect { alphabet[ nextInt( alphabet.length() ) ] }.join()
    }
  }

  private def composeFilename(def controllerName, def originalFilename, def extention=null, def tag=null) {
    def filename = (new Date()).format("MMddHHmmss") + "." + randomer(5)

    if (tag) {
      filename = tag + "." + filename
    }
    filename = controllerName + "." + filename

    if (!extention) {
      def dotIndex = originalFilename?.lastIndexOf(".")
      if (dotIndex >= 0) {
        extention = originalFilename?.substring(dotIndex+1)
      }
    }

    filename = filename + "." + extention

    return filename
  }
  private def upload(fileHandler, dirname, filename) {
    def dirRealPath = grailsApplication.mainContext.servletContext.getRealPath(dirname)
    if (!dirRealPath) {
      return null
    }

    def uploadDir = new File(dirRealPath)
    if (!uploadDir.exists()) {
      if (!uploadDir.mkdirs()) {
        return null
      }
    }

    if (fileHandler?.empty) {
      return null
    }
    try {
      def localFile = new File(dirRealPath, filename)
      localFile.append(fileHandler.inputStream)
      return localFile.getAbsolutePath()
    } catch (Exception e) {
      return null
    }
  }
}

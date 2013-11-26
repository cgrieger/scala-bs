#!/bin/bash
if [ $# -lt 2 ]
  then
    echo "Not enough arguments
    Usage: mkproject.sh <package> <projectname>
    mkproject.sh com.grieger testproject
    "
fi
PACKAGE=$1
PROJECT_NAME=$2

BUILD_FILE_CONTENT="import sbt._
import sbt.Keys._

object ${PROJECT_NAME}build extends Build {

  lazy val $PROJECT_NAME = Project(
    id = \"$PROJECT_NAME\",
    base = file(\".\"),
    settings = Project.defaultSettings ++ Seq(
      name := \"$PROJECT_NAME\",
      organization := \"$PACKAGE\",
      version := \"0.1-SNAPSHOT\",
      scalaVersion := \"2.10.2\",
      scalacOptions ++= Seq(\"-feature\", \"-deprecation\"),
      resolvers ++=  Seq(
        \"Typesafe Releases\" at \"http://repo.typesafe.com/typesafe/releases\",
        \"Sonatype Releases\" at \"https://oss.sonatype.org/content/repositories/releases/\"
      ),
      libraryDependencies ++= Seq(
        \"org.scalatest\" % \"scalatest_2.10\" % \"2.0\" % \"test\",
        \"org.scalamock\" %% \"scalamock-scalatest-support\" % \"3.0.1\" % \"test\"
      )   
	)
  )
}"

PLUGIN_FILE_CONTENT="
addSbtPlugin(\"com.github.mpeltonen\" % \"sbt-idea\" % \"1.5.1\")
"

README_FILE_CONTENT="Readme Placeholder
===

(c) Chris Grieger - 2013
"

GITIGNORE_FILE_CONTENT="project/target/
project/project/
.idea*/
target/
"

mkdir -p $PROJECT_NAME/project
echo "$BUILD_FILE_CONTENT" > $PROJECT_NAME/project/${PROJECT_NAME}Build.scala
echo "$PLUGIN_FILE_CONTENT" > $PROJECT_NAME/project/plugins.sbt
echo "$README_FILE_CONTENT" > $PROJECT_NAME/README.md
echo "$GITIGNORE_FILE_CONTENT" > $PROJECT_NAME/.gitignore
mkdir -p $PROJECT_NAME/src/{main,test}/scala


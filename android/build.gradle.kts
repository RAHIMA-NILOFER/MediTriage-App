// Top-level build file where you can add configuration options common to all sub-projects.

plugins {
    // ⚠️ IMPORTANT: Do NOT put version numbers here
    id("com.android.application") apply false
    id("com.android.library") apply false
    id("org.jetbrains.kotlin.android") apply false
   

}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// This is Flutter's recommended custom build directory setup
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

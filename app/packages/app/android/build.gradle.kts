allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.layout.buildDirectory = File("../build")
subprojects {
    project.layout.buildDirectory = File(rootProject.layout.buildDirectory.get().asFile, project.name)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

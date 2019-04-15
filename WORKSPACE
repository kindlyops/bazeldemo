workspace(name = "bazeldemo")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    sha256 = "68ef2998919a92c2c9553f7a6b00a1d0615b57720a13239c0e51d0ded5aa452a",
    strip_prefix = "bazel-skylib-8cecf885c8bf4c51e82fd6b50b9dd68d2c98f757",
    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/8cecf885c8bf4c51e82fd6b50b9dd68d2c98f757.tar.gz"],
)

load("@bazel_skylib//lib:versions.bzl", "versions")

versions.check("0.17.1")

buildtools_version = "4fe6acf537e980ff6878a51e5894605be221224c"

http_archive(
    name = "com_github_bazelbuild_buildtools",
    sha256 = "43c2df6ce1bd01b4d8173efe0795b05b19240f24ea33fde3694096f7b6043f8a",
    strip_prefix = "buildtools-%s" % buildtools_version,
    url = "https://github.com/bazelbuild/buildtools/archive/%s.zip" % buildtools_version,
)

load("@com_github_bazelbuild_buildtools//buildifier:deps.bzl", "buildifier_dependencies")

buildifier_dependencies()

# gazelle
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "77dfd303492f2634de7a660445ee2d3de2960cbd52f97d8c0dffa9362d3ddef9",
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.18.1/rules_go-0.18.1.tar.gz"],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "3c681998538231a2d24d0c07ed5a7658cb72bfb5fd4bf9911157c0e9ac6a2687",
    urls = ["https://github.com/bazelbuild/bazel-gazelle/releases/download/0.17.0/bazel-gazelle-0.17.0.tar.gz"],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

python_rules_version = "9dc48501c45aaf22215b615ce8448bfc842c18be"

http_archive(
    name = "io_bazel_rules_python",
    sha256 = "685248576801ea54dea416497259b012734450f985a1e0e3209a21b25bccb0e6",
    strip_prefix = "rules_python-%s" % python_rules_version,
    url = "https://github.com/whilp/rules_python/archive/%s.zip" % python_rules_version,
)

load("@io_bazel_rules_python//python:pip.bzl", "pip_repositories")

pip_repositories()

load("@io_bazel_rules_python//python:pip.bzl", "pip_import")

pip_import(
    name = "python",
    requirements = "//python:requirements.txt",
)

# Load the pip_install symbol and create the dependencies'
# repositories.
load("@python//:requirements.bzl", "pip_install")

pip_install()

UPSIDE_BUCKET_ANTIVIRUS_BUILD = """
exports_files(["upside_antivirus"])

filegroup(
    name = "srcs",
    srcs = [
        "requirements.txt",
    ] + glob(["*.py"]),
    visibility = ["//visibility:public"],
)
"""

# prefer http_archive to git_repository for public github projects
# http_archive provides better security, reliability, and performance than
# git_repository does.
http_archive(
    name = "com_github_upsidetravel_bucket-antivirus-function",
    build_file_content = UPSIDE_BUCKET_ANTIVIRUS_BUILD,
    sha256 = "d50fd1601278a302de60b9234eb464f658be236597ab85e6dbb68a59ea0724b7",
    strip_prefix = "bucket-antivirus-function-9a31a0c8ae89c4d2bdfaf07ef05ad84c80037c14",
    urls = ["https://github.com/upsidetravel/bucket-antivirus-function/archive/9a31a0c8ae89c4d2bdfaf07ef05ad84c80037c14.tar.gz"],
)

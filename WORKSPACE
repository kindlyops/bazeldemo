workspace(name = "bazeldemo")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

buildtools_version = "4fe6acf537e980ff6878a51e5894605be221224c"

http_archive(
    name = "com_github_bazelbuild_buildtools",
    sha256 = "43c2df6ce1bd01b4d8173efe0795b05b19240f24ea33fde3694096f7b6043f8a",
    strip_prefix = "buildtools-%s" % buildtools_version,
    url = "https://github.com/bazelbuild/buildtools/archive/%s.zip" % buildtools_version,
)

load("@com_github_bazelbuild_buildtools//buildifier:deps.bzl", "buildifier_dependencies")

buildifier_dependencies()

# prefer http_archive to git_repository for public github projects
# http_archive provides better security, reliability, and performance than
# git_repository does.
http_archive(
    name = "upside_bucket_antivirus",
    build_file = "@//:upside_bucket_antivirus.BUILD",
    sha256 = "d51d898e0902b1695cf985fef2c87d03fa75629122fc4e25976cf7394e51dd8c",
    strip_prefix = "bucket-antivirus-function-9a31a0c8ae89c4d2bdfaf07ef05ad84c80037c14",
    urls = ["https://github.com/upsidetravel/bucket-antivirus-function/archive/9a31a0c8ae89c4d2bdfaf07ef05ad84c80037c14.zip"],
)

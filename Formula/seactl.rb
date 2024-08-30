class Seactl < Formula
  desc "Development environment manager for Kubernetes."
  homepage ""
  url "https://github.com/ctxswitch/seaway/archive/refs/tags/v0.1.0-pre.10.tar.gz"
  sha256 "8c0b71e46fcb0fd339cda5ff6a589cfa040473235215e615e0b63101b928da3a"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    # require "net/http"
    # uri = URI("https://api.github.com/repos/ctxswitch/seaway/releases/latest")
    # resp = Net::HTTP.get(uri)
    # resp_json = JSON.parse(resp)
    # seaway_version = resp_json["tag_name"].sub("v", "")
    ldflags = %W[
      -s -w
      -X ctx.sh/seaway/pkg/build.Version=#{version}
    ]

    system "go", "build", "-trimpath", *std_go_args(ldflags:), "./pkg/cmd/seactl"

    generate_completions_from_executable(bin/"seactl", "completion")
  end

  test do
    assert_match "seactl version v#{version}", shell_output("#{bin}/seactl --version")
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test seactl`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end

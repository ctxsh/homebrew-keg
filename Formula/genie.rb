class Genie < Formula
  desc "Templatable generator for predictable events"
  homepage "https://github.com/ctxswitch/genie"
  url "https://github.com/ctxswitch/genie/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "3e3fd588205aeb1d088f4f315a02b187b177b6347a89238a457783b6ec803d58"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X ctx.sh/genie/pkg/build.Version=#{version}
    ]

    system "go", "build", "-trimpath", *std_go_args(ldflags:), "main.go"

    generate_completions_from_executable(bin/"genie", "completion")
  end

  test do
    assert_match "genie version #{version}", shell_output("#{bin}/genie --version").strip
  end
end

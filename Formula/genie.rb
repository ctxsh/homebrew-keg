class Genie < Formula
  desc "Templatable generator for predictable events"
  homepage "https://github.com/ctxswitch/genie"
  url "https://github.com/ctxswitch/genie/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "dc2b0ccf0802d9e4091f3700d51e7653056103f560cbaf4b8aefff795c765469"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ctxsh/homebrew-tap/releases/download/genie-0.1.7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3fc150c15b0ec3c82f90fa49d6ffa2fc82c46538c338bb56c54f6f971a0bd54b"
    sha256 cellar: :any_skip_relocation, ventura:      "822c143fb470504156628912a4755ca24565837eb02c8136c9390299560350b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6536ce491f2a520e03f72cfa77ab20dd33d0dbf3329db1c0d618c007a4153c8b"
  end

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

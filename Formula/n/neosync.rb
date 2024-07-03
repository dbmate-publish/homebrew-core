class Neosync < Formula
  desc "CLI for interfacing with Neosync"
  homepage "https://www.neosync.dev/"
  url "https://github.com/nucleuscloud/neosync/archive/refs/tags/v0.4.41.tar.gz"
  sha256 "0f0cd76df6b35b6751d8a5b9acae4e5a6f16651de3aa27ae0b76c915286f81b1"
  license "MIT"
  head "https://github.com/nucleuscloud/neosync.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4c9feb5aeb940fc184c72c76805f1d050648dbf2140f568e5db7d9447e1e9b02"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "be9b748daef11ead2c5f9deeac89630bee9d5c4bdc065c4770a41116de0cd7e0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8f8ded9c0f22a218d86a00987c3866ab544e8ec8da5effa4f26be5748979f692"
    sha256 cellar: :any_skip_relocation, sonoma:         "067cb61580dc933305e3e852b0ac6d704e5d3e80ed73b5d0e5430c5475f54334"
    sha256 cellar: :any_skip_relocation, ventura:        "322283213555ad60302c7e23a3efd78c95b018fe22b2c5a98106bb4150650d61"
    sha256 cellar: :any_skip_relocation, monterey:       "3fbb9b20881ccfb33833cf16d2c22d18cfe157582e7648e9bf0b155885cde40e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9f9f762e5f5d5e85476909dde816717e59e0b5644c9174dd6093b40faa0585d6"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/nucleuscloud/neosync/cli/internal/version.gitVersion=#{version}
      -X github.com/nucleuscloud/neosync/cli/internal/version.gitCommit=#{tap.user}
      -X github.com/nucleuscloud/neosync/cli/internal/version.buildDate=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cli/cmd/neosync"

    generate_completions_from_executable(bin/"neosync", "completion")
  end

  test do
    output = shell_output("#{bin}/neosync connections list 2>&1", 1)
    assert_match "connect: connection refused", output

    assert_match version.to_s, shell_output("#{bin}/neosync --version")
  end
end

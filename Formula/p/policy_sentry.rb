class PolicySentry < Formula
  include Language::Python::Virtualenv

  desc "Generate locked-down AWS IAM Policies"
  homepage "https://policy-sentry.readthedocs.io/en/latest/"
  url "https://files.pythonhosted.org/packages/7e/7a/7fbb394f21a3c43edcb7d04382b6d93567900b4c8ea4b224b284656115ed/policy_sentry-0.12.11.tar.gz"
  sha256 "8db1ea570e835d87c57ef51bf6f2372a8b78d463549a5f9c65cb5f8103cd1ed8"
  license "MIT"
  revision 3
  head "https://github.com/salesforce/policy_sentry.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "4e2758649b1f5931549ceffb9735f503b5ee3e7fb3d10112f47d27fdfba9dee6"
    sha256 cellar: :any,                 arm64_ventura:  "619932791ef3987f46ebb381f403b8ba7ff8b80a0e0be64c9cec2410bc5355e3"
    sha256 cellar: :any,                 arm64_monterey: "abc80581116f816c879c808bea0d27d9b5089ff2f9bbf2630d2b059279a3d322"
    sha256 cellar: :any,                 sonoma:         "e4c0df0a3f35a639d5997589b91dfb26315966b26b25f9d363d39f1b76ce06c3"
    sha256 cellar: :any,                 ventura:        "d1fbe3f7b2c2250785d5b6bbf78983dfa477f94b564dd15621f29b6494fa43b8"
    sha256 cellar: :any,                 monterey:       "02ca0fe4f9477af07aae4f1c7f2c0f194f1cbef38d9d3d7fcb7b1d5d9a6c2d89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "556914d4c45e3753d8423437b127d3de1ff5f07e86c65a2a08d3a084c642ca8c"
  end

  depends_on "certifi"
  depends_on "libyaml"
  depends_on "python@3.12"

  resource "beautifulsoup4" do
    url "https://files.pythonhosted.org/packages/b3/ca/824b1195773ce6166d388573fc106ce56d4a805bd7427b624e063596ec58/beautifulsoup4-4.12.3.tar.gz"
    sha256 "74e3d1928edc070d21748185c46e3fb33490f22f52a3addee9aee0f4f7781051"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f30c3cb33b24454a82faecaf01b19c18562b1e89558fb6c56de4d9118a032fd5"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/21/ed/f86a79a07470cb07819390452f178b3bef1d375f2ec021ecfc709fc7cf07/idna-3.7.tar.gz"
    sha256 "028ff3aadf0609c1fd278d8ea3089299412a7a8b9bd005dd08b9f8285bcb5cfc"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0/PyYAML-6.0.1.tar.gz"
    sha256 "bfdf460b1736c775f2ba9f6a92bca30bc2095067b8a9d77876d1fad6cc3b4a43"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "schema" do
    url "https://files.pythonhosted.org/packages/d4/01/0ea2e66bad2f13271e93b729c653747614784d3ebde219679e41ccdceecd/schema-0.7.7.tar.gz"
    sha256 "7da553abd2958a19dc2547c388cde53398b39196175a9be59ea1caf5ab0a1807"
  end

  resource "soupsieve" do
    url "https://files.pythonhosted.org/packages/ce/21/952a240de1c196c7e3fbcd4e559681f0419b1280c617db21157a0390717b/soupsieve-2.5.tar.gz"
    sha256 "5663d5a7b3bfaeee0bc4372e7fc48f9cff4940b3eec54a6451cc5299f1097690"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/43/6d/fa469ae21497ddc8bc93e5877702dca7cb8f911e337aca7452b5724f1bb6/urllib3-2.2.2.tar.gz"
    sha256 "dd505485549a7a552833da5e6063639d0d177c04f23bc3864e41e5dc5f612168"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/policy_sentry --version")

    system bin/"policy_sentry", "initialize"
    assert_predicate testpath/".policy_sentry/iam-definition.json", :exist?
  end
end

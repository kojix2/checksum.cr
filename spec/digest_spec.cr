require "./spec_helper"

ALGORITHMS = {
  md5:    CheckSum::Algorithm::MD5,
  sha1:   CheckSum::Algorithm::SHA1,
  sha256: CheckSum::Algorithm::SHA256,
  sha512: CheckSum::Algorithm::SHA512,
}

describe CheckSum::Digest do
  it "creates appropriate digest instances based on algorithm" do
    ALGORITHMS.each do |_suffix, algorithm|
      digest = CheckSum::Digest.new(algorithm)
      case algorithm
      when CheckSum::Algorithm::MD5
        digest.inspect.should match(/Digest::MD5/)
        digest.algorithm.should eq CheckSum::Algorithm::MD5
      when CheckSum::Algorithm::SHA1
        digest.inspect.should match(/Digest::SHA1/)
        digest.algorithm.should eq CheckSum::Algorithm::SHA1
      when CheckSum::Algorithm::SHA256
        digest.inspect.should match(/Digest::SHA256/)
        digest.algorithm.should eq CheckSum::Algorithm::SHA256
      when CheckSum::Algorithm::SHA512
        digest.inspect.should match(/Digest::SHA512/)
        digest.algorithm.should eq CheckSum::Algorithm::SHA512
      else
        raise "Unexpected algorithm #{algorithm}"
      end
    end
  end

  it "successfully computes the hex checksum of a file" do
    expected_checksum = {
      md5:    "d41d8cd98f00b204e9800998ecf8427e",
      sha1:   "da39a3ee5e6b4b0d3255bfef95601890afd80709",
      sha256: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      sha512: "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e",
    }

    ALGORITHMS.each do |suffix, algorithm|
      File.tempfile("checksum_test", suffix.to_s) do |temp_file|
        # Do not insert a newline at the end of the file
        # as it will change the checksum on some systems
        temp_file.print("Test data for checksumming")
        digest = CheckSum::Digest.new(algorithm)
        digest.hexfinal(temp_file.path)
          .should eq expected_checksum[suffix]

        # Reset the digest and recompute the checksum
        digest.reset
        digest = CheckSum::Digest.new(algorithm)
        digest.hexfinal(temp_file.path)
          .should eq expected_checksum[suffix]
      end
    end
  end
end

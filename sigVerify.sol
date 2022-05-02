// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


/* Signature Verification

How to Sign and Verify
# Signing
1. Create message to sign
2. Hash the message
3. Sign the hash with private key(off chain, keep your private key secret)

# Verify
1. Recreate hash from the original message and then take the hash of hash by adding predefined string at the start of the hash
2. Recover signer from signature and hash: ecrecover(hash(message), signature)
3. Compare recovered signer to claimed signer
*/

contract SigVerification {
    function verify(address _signer, string memory _message, bytes memory _sig) external pure returns (bool) {
        bytes32 msgHash = getMsgHash(_message);
        bytes32 ethMsgHash = getEthMsgHash(msgHash);

        return recover(ethMsgHash, _sig) == _signer;
    }

    function getMsgHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthMsgHash(bytes32 _msgHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",_msgHash));
    }

    function recover(bytes32 _ethMsgHash, bytes memory _sig) public pure returns (address) {
        // r and s are cryptographic parameter used for digital signature
        // v is something unique to ethereum
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);

        return ecrecover(_ethMsgHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure returns(bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "Invalid signature length");

        assembly{
            /*
            _sig is just a pointer to signature in storage
            First 32 bytes stores the length of the signature
            (in all dynamic variable first 32 bytes always stores the length

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */
            // first 32 bytes, after the length prefix
            r := mload(add(_sig, 32))
            // second 32 bytes
            s := mload(add(_sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}
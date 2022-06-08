# SPDX-License-Identifier: MIT

%lang starknet

struct ContractAddressType:
    member membership: felt
    member governor: felt
    member treasury: felt
    member share_token: felt
    member share_governor: felt
end
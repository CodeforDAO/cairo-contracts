# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.hash import hash2
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import get_caller_address

from openzeppelin.token.erc721.library import (
    ERC721_name,
    ERC721_symbol,
    ERC721_balanceOf,
    ERC721_ownerOf,
    ERC721_getApproved,
    ERC721_isApprovedForAll,
    ERC721_tokenURI,
    ERC721_approve,
    ERC721_setApprovalForAll,
    ERC721_transferFrom,
    ERC721_safeTransferFrom,
    ERC721_burn,
    ERC721_safeMint,
    ERC721_initializer,
    ERC721_only_token_owner,
    ERC721_setTokenURI,
)

from openzeppelin.token.erc721_enumerable.library import (
    ERC721_Enumerable_initializer,
    ERC721_Enumerable_totalSupply,
    ERC721_Enumerable_tokenByIndex,
    ERC721_Enumerable_tokenOfOwnerByIndex,
    ERC721_Enumerable_mint,
    ERC721_Enumerable_burn,
    ERC721_Enumerable_transferFrom,
    ERC721_Enumerable_safeTransferFrom
)

from openzeppelin.introspection.ERC165 import ERC165
from openzeppelin.security.pausable import Pausable
from immutablex.starknet.access.AccessControl import AccessControl, DEFAULT_ADMIN_ROLE

from src.codefordao.libraries.structs import ContractAddressType
from src.codefordao.libraries.merkle import merkle_verify

#
# Constants
#

const MINTER_ROLE = 'MINTER_ROLE'
const INVITER_ROLE = 'INVITER_ROLE'

#
# Storage
#
@storage_var
func contract_uri() -> (uri: felt):
end

@storage_var
func investor(token_id: Uint256) -> (res: felt):
end

@storage_var
func contracts_addresses(contract_type: ContractAddressType) -> (addr: felt):
end

@storage_var
func merkle_root() -> (root: felt):
end

#
# Initializer
#
@constructor
func constructor{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(
        name: felt,
        symbol: felt,
        default_admin: felt
    ):
    ERC721_initializer(name, symbol)
    ERC721_Enumerable_initializer()
    AccessControl.initializer(default_admin)
    return ()
end

#
# Getters
#

@view
func totalSupply{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }() -> (totalSupply: Uint256):
    let (totalSupply: Uint256) = ERC721_Enumerable_totalSupply()
    return (totalSupply)
end

@view
func tokenByIndex{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(index: Uint256) -> (tokenId: Uint256):
    let (tokenId: Uint256) = ERC721_Enumerable_tokenByIndex(index)
    return (tokenId)
end

@view
func tokenOfOwnerByIndex{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(owner: felt, index: Uint256) -> (tokenId: Uint256):
    let (tokenId: Uint256) = ERC721_Enumerable_tokenOfOwnerByIndex(owner, index)
    return (tokenId)
end

@view
func supportsInterface{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(interfaceId: felt) -> (success: felt):
    let (success) = ERC165.supports_interface(interfaceId)
    return (success)
end

@view
func name{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }() -> (name: felt):
    let (name) = ERC721_name()
    return (name)
end

@view
func symbol{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }() -> (symbol: felt):
    let (symbol) = ERC721_symbol()
    return (symbol)
end

@view
func balanceOf{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(owner: felt) -> (balance: Uint256):
    let (balance) = ERC721_balanceOf(owner)
    return (balance)
end

@view
func ownerOf{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(token_id: Uint256) -> (owner: felt):
    let (owner) = ERC721_ownerOf(token_id)
    return (owner)
end

@view
func getApproved{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(token_id: Uint256) -> (approved: felt):
    let (approved) = ERC721_getApproved(token_id)
    return (approved)
end

@view
func isApprovedForAll{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(owner: felt, operator: felt) -> (isApproved: felt):
    let (isApproved) = ERC721_isApprovedForAll(owner, operator)
    return (isApproved)
end

@view
func tokenURI{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(tokenId: Uint256) -> (tokenURI: felt):
    let (tokenURI) = ERC721_tokenURI(tokenId)
    return (tokenURI)
end

@view
func contractURI{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }() -> (owner: felt):
    let (uri) = contract_uri()
    return (uri)
end

@view
func isInvestor{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(token_id: Uint256) -> (res: felt):
    let (res) = investor.read(token_id)
    return (res)
end

@view
func paused{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }() -> (paused: felt):
    let (paused) = Pausable.is_paused()
    return (paused)
end

@view
func hasRole{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    role : felt, account : felt
) -> (res : felt):
    let (res) = AccessControl.has_role(role, account)
    return (res)
end

@view
func getRoleAdmin{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    role : felt
) -> (role_admin : felt):
    let (role_admin) = AccessControl.get_role_admin(role)
    return (role_admin)
end

#
# Externals
#

@external
func setContractURI{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(uri: felt):
    AccessControl.only_role(DEFAULT_ADMIN_ROLE)
    contract_uri.write(uri)
    return ()
end

@external
func setMerkleRoot{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(root: felt):
    AccessControl.only_role(INVITER_ROLE)
    merkle_root.write(root)
    return ()
end

@external
func setupGovernor{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(
        governor_addr: felt,
        treasury_addr: felt,
        share_token_addr: felt,
        share_governor_addr: felt
    ):
    AccessControl.only_role(DEFAULT_ADMIN_ROLE)
    contracts_addresses.write(ContractAddressType.treasury, treasury_addr)
    contracts_addresses.write(ContractAddressType.governor, governor_addr)
    contracts_addresses.write(ContractAddressType.share_token, share_token_addr)
    contracts_addresses.write(ContractAddressType.share_governor, share_governor_addr)
    return ()
end

@external
func approve{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(to: felt, tokenId: Uint256):
    Pausable.assert_not_paused()
    ERC721_approve(to, tokenId)
    return ()
end

@external
func setApprovalForAll{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(operator: felt, approved: felt):
    Pausable.assert_not_paused()
    ERC721_setApprovalForAll(operator, approved)
    return ()
end

@external
func transferFrom{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(from_: felt, to: felt, tokenId: Uint256):
    Pausable.assert_not_paused()
    ERC721_Enumerable_transferFrom(from_, to, tokenId)
    return ()
end

@external
func safeTransferFrom{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(from_: felt, to: felt, tokenId: Uint256, data_len: felt, data: felt*):
    Pausable.assert_not_paused()
    ERC721_Enumerable_safeTransferFrom(from_, to, tokenId, data_len, data)
    return ()
end

@external
func pause{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }():
    AccessControl.only_role(DEFAULT_ADMIN_ROLE)
    Pausable._pause()
    return ()
end

@external
func unpause{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }():
    AccessControl.only_role(DEFAULT_ADMIN_ROLE)
    Pausable._unpause()
    return ()
end

@external
func burn{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(tokenId: Uint256):
    Pausable.assert_not_paused()
    ERC721_only_token_owner(tokenId)
    ERC721_Enumerable_burn(tokenId)
    return ()
end

@external
func mint{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(
        proof_len: felt,
        proof: felt*
        token_id: Uint256
    ):
    alloc_locals

    Pausable.assert_not_paused()

    let (sender) = get_caller_address()
    let local amount = Uint256(0, 1)
    let (amount_hash) = hash2{hash_ptr=pedersen_ptr}(amount.low, amount.high)
    let (leaf) = hash2{hash_ptr=pedersen_ptr}(sender, amount_hash)

    let (local root) = merkle_root.read()
    let (proof_valid) = merkle_verify(leaf, root, proof_len, proof)

    assert proof_valid = 1

    ERC721_Enumerable_mint(sender, tokenId)
    return ()
end

@external
func setTokenURI{
        pedersen_ptr: HashBuiltin*,
        syscall_ptr: felt*,
        range_check_ptr
    }(tokenId: Uint256, tokenURI: felt):
    AccessControl.only_role(DEFAULT_ADMIN_ROLE)
    ERC721_setTokenURI(tokenId, tokenURI)
    return ()
end

#
# Access control related functions
#

@external
func grantRole{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    role : felt, 
    account : felt
):
    AccessControl.grant_role(role, account)
    return ()
end

@external
func revokeRole{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    role : felt, 
    account : felt
):
    AccessControl.revoke_role(role, account)
    return ()
end

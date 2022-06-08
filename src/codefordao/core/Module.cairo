# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_le, assert_lt
from starkware.starknet.common.syscalls import call_contract, get_caller_address

from src.codefordao.libraries.structs import ContractAddressType

#
# Events
#

@event
func ModuleProposalCreated(
        module_addr: felt, 
        operator_addr : felt, 
        id : felt, 
        timestamp : felt
    ):
end

@event
func ModuleProposalConfirmed(
        module_addr: felt, 
        operator_addr : felt, 
        id : felt, 
        timestamp : felt
    ):
end

@event
func ModuleProposalScheduled(
        module_addr: felt, 
        operator_addr : felt, 
        id : felt, 
        timestamp : felt
    ):
end

@event
func ModuleProposalExecuted(
        module_addr: felt, 
        operator_addr : felt, 
        id : felt, 
        timestamp : felt
    ):
end

@event
func ModuleProposalCancelled(
        module_addr: felt, 
        operator_addr : felt, 
        id : felt, 
        timestamp : felt
    ):
end

#
# Storage
#

struct Transaction:
    member to : felt
    member function_selector : felt
    member calldata_len : felt
    member executed : felt
    member num_confirmations : felt
end

@storage_var
func _name() -> (uri: felt):
end

@storage_var
func _description() -> (uri: felt):
end

@storage_var
func _addresses(addr_type: ContractAddressType) -> (addr: felt):
end

namespace CodeforDAO_Module:

    #
    # Initializer
    #
    func module_initializer{
            syscall_ptr: felt*,
            pedersen_ptr: HashBuiltin*,
            range_check_ptr
        }(
            name: felt,
            description: felt,
            membership_addr: felt,
            operators_len: felt,
            operators: felt*,
            timelock_delay: felt
        ):
        _name.write(name)
        _description.write(description)
        _addresses.write(addr_type=ContractAddressType.membership, addr=membership_addr)
        return ()
    end

    #
    # Public functions
    #
    func listOperators{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }() -> (_operators: [Uint256]):
    end

    func getMembershipTokenId{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }() -> ():
    end

    func getAddressByMemberId{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }() -> ():
    end

    func getProposal{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }(proposal_id: felt) -> ():
    end

    func propose{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }() -> ():
    end

    func confirm{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }(proposal_id: felt) -> ():
    end

    func schedule{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }(proposal_id: felt) -> ():
    end

    func execute{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }(proposal_id: felt) -> ():
    end

    func cancel{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }(proposal_id: felt) -> ():
    end

    #
    # Internal
    #
    func pullPayments{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }() -> ():
    end
end
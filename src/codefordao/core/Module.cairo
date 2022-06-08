# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_le, assert_lt
from starkware.starknet.common.syscalls import call_contract, get_caller_address

from src.codefordao.libraries.structs import ContractAddressType
from src.codefordao.libraries.utils import Arrays

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
func _operators_key() -> (res: felt):
end

@storage_var
func _addresses(addr_type: ContractAddressType) -> (addr: felt):
end

namespace CodeforDAO_Module:

    #
    # Initializer
    #
    func initializer{
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

        let (_key) = Arrays.push(arr_len=operators_len, arr=operators)
        _operators_key.write(_key)

        return ()
    end

    #
    # Public functions
    #
    func operators{
            pedersen_ptr: HashBuiltin*,
            syscall_ptr: felt*,
            range_check_ptr
        }() -> (
            operators_len: felt,
            operators: felt*
        ):

        let (key) = _operators_key.read()
        let (arr_len, arr) = Arrays.get_array(key)

        return (operators_len=arr_len, operators=arr)
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
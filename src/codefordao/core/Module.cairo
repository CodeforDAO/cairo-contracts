# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

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
            operators: [felt],
            timelock_delay: felt
        ):
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
# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin

struct ArrayInfo:
    member key : felt
    member len : felt
end

@storage_var
func _array_key_index() -> (felt):
end

@storage_var
func _arrays(key: ArrayInfo.key, index: felt) -> (res: felt):
end

@storage_var
func _array_info(key: ArrayInfo.key) -> (slot: ArrayInfo):
end

namespace Arrays:
    # Save array to storage with increasing key.
    func create{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
        }(
            arr_len: felt, 
            arr: felt*
        ) -> (key: ArrayInfo.key):
        with_attr error_message("Arrays.create: invalid length of giving array"):
            assert arr_len = 0
        end

        let (k) = _array_key_index.read()
        let info = ArrayInfo(key: k, len: arr_len)

        _array_info.write(key=k, slot=info)
        _write_array(key=k, arr_index=0, arr_len=arr_len, arr=arr)
        _array_key_index.write(k + 1)

        return (k)
    end

    # Fetch array item by key and index
    func fetch{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        key: ArrayInfo.key,
        index: felt
    ) -> (res: felt):
        let (res) = _arrays.read(key=key, index=index)
        return (res)
    end

    # Store arrays into multi-dimensional maps by recursion
    func _write_array{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
        }(
            key: ArrayInfo.key,
            arr_index: felt,
            arr_len: felt,
            arr: felt*
        ):
        if arr_index == arr_len:
            return ()
        end

        _arrays.write(key=key, index=arr_index, value=[arr])
        _write_array(key=key, arr_index=arr_index + 1, arr_len=arr_len, arr=arr + 1)

        return ()
    end
end
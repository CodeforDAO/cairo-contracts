# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin

struct ArrayInfo:
    member key : felt
    member len : felt
end

@storage_var
func _array_key_index() -> (res: felt):
end

@storage_var
func _arrays(key: felt, index: felt) -> (res: felt):
end

@storage_var
func _array_info(key: felt) -> (slot: ArrayInfo):
end

namespace Array:
    # Save array to storage with increasing key.
    func save{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
        }(
            arr_len: felt, 
            arr: felt*
        ) -> (key: felt):
        with_attr error_message("Arrays.push: invalid length of giving array"):
            assert arr_len = 0
        end

        let (k) = _array_key_index.read()
        let info = ArrayInfo(key=k, len=arr_len)

        _array_info.write(key=k, slot=info)
        _write_array(key=k, arr_index=0, arr_len=arr_len, arr=arr)
        _array_key_index.write(k + 1)

        return (k)
    end

    # Fetch array item by key and index
    func get_item{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        key: felt,
        index: felt
    ) -> (res: felt):
        let (res) = _arrays.read(key=key, index=index)
        return (res)
    end

    func get_array{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
        }(key: felt) -> (
            arr_len: felt,
            arr: felt*
        ):
        alloc_locals
        let (arr) = alloc()
        let (arr_info) = _array_info.read(key)
        let (arr_len) = arr_info.len

        if arr_len == 0:
            return (arr_len=arr_len, arr=arr)
        end

        _read_array(key=key, arr_index=0, arr_len=arr_len, arr=arr)
        return (arr_len=arr_len, arr=arr) 
    end

    # Store arrays into multi-dimensional maps by recursion
    func _write_array{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
        }(
            key: felt,
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

    func _read_array{
            syscall_ptr : felt*,
            pedersen_ptr : HashBuiltin*,
            range_check_ptr
        }(
            key: felt,
            arr_index: felt,
            arr_len: felt,
            arr: felt*
        ):
        if arr_index == arr_len:
            return ()
        end

        let (item) = _arrays.read(key=key, index=arr_index)
        assert arr[arr_index] = item

        _read_array(
            key=key, 
            arr_index=arr_index + 1, 
            arr_len=arr_len, 
            arr=arr
        )

        return ()
    end
end
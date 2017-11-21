note
	description: "A Dictionary ADT mapping from keys to values"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	-- Constrained genericity because V and K will be used
	-- in the math model class FUN, which require both to be always
	-- attached for void safety.
	DICTIONARY[V -> attached ANY, K -> attached ANY]
inherit
	ITERABLE[TUPLE[V, K]]
create
	make

feature {NONE}
	values: ARRAY[V]
	keys: LINKED_LIST[K]

feature -- Abstraction function
	model: FUN[K, V] -- Do not modify the type of this query.
			-- Abstract the dictionary ADT as a mathematical function.
		local
			i:INTEGER
			p:PAIR[K,V]
		do
			create result.make_empty

			from
				i := 1
			until
				i = count + 1
			loop
				create p.make (keys[i], values[i])
				result.extend(p) --(create {PAIR[K,V]}.make(keys[i],values[i]))
				i := i + 1
			end

		ensure
			consistent_model_imp_counts:
				model.count = count
			consistent_model_imp_contents:
			across
			1 |..| result.count as j
			all
				result.has (create {PAIR[K, V]}.make (keys[j.item], values[j.item]))
			end

				-- Your Task: applying the model function on each key
				-- gives back the corresponding value
		end

feature -- feature required by ITERABLE
	new_cursor: ITERATION_CURSOR[TUPLE[V, K]]
		do
			Result := create {TUPLE_ITERATION_CURSOR[V,K]}.make(values,keys)
		end

feature -- Constructor
	make
			-- Initialize an empty dictionary.
		do
			create values.make_empty
			create keys.make
			values.compare_objects
			keys.compare_objects

		ensure
			empty_model: model.is_empty
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_values:
				values.object_comparison
		end

feature -- Commands

	add_entry (v: V; k: K)
		require
			non_existing_in_model: not model.domain.has (k)
		do
			keys.force (k)
			values.force (v, values.upper + 1)
			--model.extend ([k,v])
		ensure
			entry_added_to_model:
				model ~ old model.extended ([k, v])
		end

	remove_entry (k: K)
		require
			existing_in_model: model.domain.has(k)
		local
			n:INTEGER
		do
			n := keys.index_of (k, 1)-- does this return an int?
			keys.go_i_th (n)
			keys.remove
			from
			until
				n = values.upper
			loop
				values[n] := values[n + 1]
				n := n + 1
			end
			values.remove_tail (1)
		ensure
			entry_removed_from_model:
				model ~ (old model.deep_twin.domain_subtracted_by (k))
		end

feature -- Queries

	count: INTEGER
			-- Number of keys in BST.
		do
			result := keys.count
		ensure
			correct_model_result:
				model.count = count
		end

	get_keys (v: V): ITERABLE[K]
			-- Keys that are associated with value 'v'.
	local
			n:INTEGER
			l:LINKED_LIST[K]
		do
			create l.make
			from
				n := 1
			until
				n = keys.count + 1
			loop
				if values[n] ~ v then
					l.extend(keys.at(n))
				end
				n := n + 1
			end
			Result := l

		ensure
		correct_model_result:
			across result as j all
				model.range_restricted_by(v).domain.has(j.item)
				end
		end


	get_value (k: K): detachable V
			-- Assocated value of 'k' if it exists.
			-- Void if 'k' does not exist.
	local
			n:INTEGER
		do
			if (keys.has (k)) then
				n := keys.index_of (k, 1)
				Result := values.at (n)
		end
		ensure
			case_of_void_result: not model.domain.has (k) implies (result = void)
				-- Your Task: void result means the key does not exist in model
			case_of_non_void_result: model.domain.has (k) implies (not(result = void))
				-- Your Task: void result means the key exists in model
		end
invariant
	consistent_keys_values_counts:
		keys.count = values.count
	consistent_imp_adt_counts:
		keys.count = count
end

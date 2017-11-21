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

feature {NONE} -- Do not modify this export status!
	values: ARRAY[V]
	keys: LINKED_LIST[K]

feature -- Abstraction function
	model: FUN[K, V] -- Do not modify the type of this query.
			-- Abstract the dictionary ADT as a mathematical function.
		local
			a:ARRAY[TUPLE[V,K]]
		do
			create a.make_empty
			across current as c loop a.force (current.new_cursor.item, a.count + 1 ) end

			create Result.make_empty
			create Result.make_from_array(a)


		ensure
			consistent_model_imp_counts: model.count = count
				-- Your Task: sizes of model and implementations the same
			consistent_model_imp_contents:

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
			non_existing_in_model: not model.has ([k,v])
		do
			model.extend ([k,v])
		ensure
			entry_added_to_model:
				model ~ old model.extended ([k, v])
		end

	remove_entry (k: K)
		require
			existing_in_model: true
				-- Your Task
		local
			v:V
		do
			v := current.get_value (k)
		--	model.subtract ([k,v])
		ensure
			entry_removed_from_model:
			--	model ~ old model.subtracted ([k])

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
			ll:LINKED_LIST[K]--temporary local var
		do
			create ll.make
			Result := ll
			-- Your Task
		ensure
			correct_model_result: True
				-- Your Task: Every key in the result
				--has the right corresponding value in model
		end

	get_value (k: K): detachable V
			-- Assocated value of 'k' if it exists.
			-- Void if 'k' does not exist.
		do
			-- Your Task
		ensure
			case_of_void_result: True
				-- Your Task: void result means the key does not exist in model
			case_of_non_void_result: True
				-- Your Task: void result means the key exists in model
		end
invariant
	consistent_keys_values_counts:
		keys.count = values.count
	consistent_imp_adt_counts:
		keys.count = count
end

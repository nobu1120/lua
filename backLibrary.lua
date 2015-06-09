-- backLibrary.lua
-- Comment : backLibrary.lua
-- date : 2015 - 06 - 08
-- creater : Nobuyoshi Tanaka
-- comment : 戻るボタン実装
----------------------------------------

local backLibrary = {}

-- ページごとに戻るボタンのアクションを入れていく
backActionTable = {}
backLibrary.uniqIdTable = {}

function backLibrary.init()

	backActionTable = nil
	backActionTable = {}

	backLibrary.uniqIdTable = nil
	backLibrary.uniqIdTable = {}

end

-- 初回
local first = true

-- ユニークなidを作る(digit : 桁数)
function backLibrary.createUniqId( digit )

	assert( digit , "Error : digit is nil value ")

	function returnUniqId()

		-- まだ重複は取り除いていない
		local id = math.random(1,9)
		local t = {}

		for i = 1 , digit do
			t[i] = math.random(1,9)
			id = id .. t[i]
		end

		if first == true then
			return id
		else
			-- ここで重複を取り除く
			return checkUniq(id)
		end
	end

	local function addUniqId(id)


		assert( id , "Error : id is nil value" )

		backLibrary.uniqIdTable[#backLibrary.uniqIdTable + 1] = id
	end

	-- 重複してないか確認
	function checkUniq(id)

		assert( id , "Error : id is nil value" )
		
		if backLibrary.uniqIdTable then
			for k,v in pairs(backLibrary.uniqIdTable) do
				-- 重複時はもう一度id作成
				if v == id then
					return returnUniqId()
				end
			end
		end
		return id
	end

	if first == true then

		local id = returnUniqId()
		addUniqId(id)
		first = false

		return id
	else
	
		local id = returnUniqId()
		addUniqId(id)

		return id
	end
end

-- sceneかそれ以外でkeyを分けて戻るアクションを保持しておく
function backLibrary.addAction( id , action )

	if type(action) == "function" then

		if type(id) == "number" then

			backActionTable[id] = action
		
		else
			print("Error : id expected number but got "..type( id ))
		end

	else
		print("Error : action expected function but got " .. type( action ))
	end
end

-- 一致する戻るアクション実行
function backLibrary.back( id )

	if type(id) == "number" then
	
		for k,v in pairs(backActionTable) do
			if k == id then
				v()
			end
		end

	else
		print("Error : id expected function but got " .. type( id ))
	end
end

-- 一致するアクション削除
function backLibrary.destroy( id )

	if type(id) == "number" then

		for k,v in pairs(backActionTable) do
			if k == id then
				backActionTable[k] = nil
				k = nil
			end
		end

	else
		print("Error : id expected function but got " .. type( id ))
	end
end

return backLibrary
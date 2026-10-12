import json, random

# Data Storage
clubs = {
    "مصر": ["الشناوي", "محمد صلاح", "مرموش", "مصطفى محمد", "تريزيجيه"],
    "السنغال": ["ماني", "ميندي", "كوليبالي"],
    "الأرجنتين": ["ميسي", "ديبالا", "لاوتارو"],
    "البرازيل": ["فينيسيوس", "نيمار", "أليسون"],
    "الأساطير": ["مارادونا", "بيليه", "رونالدينيو", "مالديني", "كرويف"]
}

managers = ["غوارديولا", "أنشيلوتي", "كلوب", "حسام حسن", "مورينيو"]
formations = ["4-3-3", "4-2-3-1", "3-5-2", "4-4-2"]

packages = {
    "Epic: Highlight Legends": ["مارادونا", "بيليه", "رونالدينيو"],
    "Showtime: National Stars": ["محمد صلاح", "مرموش", "فينيسيوس"],
    "POTW: European Club": ["تريزيجيه", "ماني", "لاوتارو"]
}

# Player State
game_state = {
    "coins": 500,
    "dev_mode": False,
    "inventory": [],
    "squad": [],
    "manager": None,
    "formation": "4-3-3",
    "cursor_pos": [0, 0]
}

def move_cursor(direction):
    """التحكم بالسهم لنقل أي شيء"""
    x, y = game_state["cursor_pos"]
    if direction == "up": y += 1
    elif direction == "down": y -= 1
    elif direction == "left": x -= 1
    elif direction == "right": x += 1
    game_state["cursor_pos"] = [x, y]
    return f"📍 موقع السهم الحالي: X={x}, Y={y}"

def redeem_gift_code(code):
    """قسم الهدايا وإدخال الأكواد"""
    code = str(code).strip().lower()
    if code == "adham":
        game_state["dev_mode"] = True
        return "🔓 تم تفعيل (وضع التطور) بنجاح! يمكنك الآن تعديل أي شيء."
    elif code == "adham123":
        game_state["coins"] += 10_000_000
        return "💰 تم إضافة 10,000,000 كوينز إلى حسابك!"
    else:
        return "❌ كود خاطئ!"

def open_package(pkg_name):
    """فتح البكجات وتفتيح الكروت"""
    if game_state["coins"] < 100:
        return "⚠️ لا توجد كوينز كافية! ادخل كود الهدايا adham123"
    
    if pkg_name not in packages:
        return "❌ البكج غير موجود."

    game_state["coins"] -= 100
    player_drawn = random.choice(packages[pkg_name])
    game_state["inventory"].append(player_drawn)
    return f"🌟 مبروك! حصلت على اللاعب [{player_drawn}] من بكج ({pkg_name})! المتبقي: {game_state['coins']} كوينز."

def ai_chat(user_msg):
    """نظام التحديث والتحدث مع اللعبة"""
    msg = user_msg.lower()
    if "تحديث" in msg:
        return "🤖 اللعبة: جاري سحب أحدث طاقات اللاعبين وتشكيلات منتخبات أفريقيا، مصر، وأمريكا الجنوبية..."
    elif "مرحبا" in msg or "ازيك" in msg:
        return "🤖 اللعبة: أهلاً بك يا كابتن! جاهز لتطوير تشكيلتك اليوم؟"
    else:
        return f"🤖 اللعبة: استلمت رسالتك ({user_msg}). كل الأسطول والبطاقات جاهزة للتكتيك!"

# --- تجربة النظام ---
print("=== eFootball Engine Simulated ===")
print(redeem_gift_code("adham"))      # تفعيل وضع التطور
print(redeem_gift_code("adham123"))   # الحصول على 10 مليون كوينز
print(move_cursor("right"))           # تحريك السهم
print(open_package("Epic: Highlight Legends")) # فتح بكج الأساطير
print(ai_chat("اعمل تحديث للعبه"))     # التحدث مع اللعبة
-- ====================================================
-- Game Title: eChampions Arena 2026
-- Description: PES-Style Core System Script
-- ====================================================

GameSystem = {
    Name = "eChampions Arena 2026",
    PlayerAccount = {
        Coins = 0,
        Inventory = {}
    }
}

-- ====================================================
-- 1. قاعدة بيانات البكجات والفرق (Packs & Squads)
-- ====================================================
PacksDatabase = {
    NationalTeams = {
        "Egypt_Pack",      -- منتخب مصر
        "France_Pack",     -- منتخب فرنسا
        "Belgium_Pack",    -- منتخب بلجيكا
        "Argentina_Pack",  -- منتخب الأرجنتين
        "Portugal_Pack"    -- منتخب البرتغال
    },
    Clubs = {
        "FC_Barcelona_Pack" -- نادي برشلونة
    },
    SpecialPacks = {
        "Legendary_GOAT_Pack", -- بكج ميسي وكريستيانو
        "All_Stars_Pack"       -- بكج كبار اللاعبين (سواريز، مارين، إلخ)
    }
}

-- قاعدة بيانات اللاعبين الأساطير والنجوم
PlayersDatabase = {
    Legends = {
        { id = 101, name = "Lionel Messi", rating = 99, cardType = "Legend" },
        { id = 102, name = "Cristiano Ronaldo", rating = 99, cardType = "Legend" }
    },
    Stars = {
        { id = 201, name = "Luis Suárez", rating = 93, cardType = "Epic" },
        { id = 202, name = "Marin", rating = 88, cardType = "Featured" }
    }
}

-- ====================================================
-- 2. نظام أكواد الهدايا (Gift Code System)
-- ====================================================
RedeemedCodes = {}

function RedeemGiftCode(code)
    -- التحقق من استخدام الكود سابقاً
    if RedeemedCodes[code] then
        print("[System] هذا الكود تم استخدامه من قبل!")
        return
    end

    local cleanCode = string.lower(code)

    -- الكود الأول: "adham" -> 600,000 كوينز
    if cleanCode == "adham" then
        GameSystem.PlayerAccount.Coins = GameSystem.PlayerAccount.Coins + 600000
        RedeemedCodes[code] = true
        print("[نجاح] تم إضافة 600,000 كوينز إلى حسابك! الرصيد الحالي: " .. GameSystem.PlayerAccount.Coins)

    -- الكود الثاني: "adham123" -> لاعبين أساطير (ميسي وكريستيانو)
    elseif cleanCode == "adham123" then
        table.insert(GameSystem.PlayerAccount.Inventory, PlayersDatabase.Legends[1]) -- Messi
        table.insert(GameSystem.PlayerAccount.Inventory, PlayersDatabase.Legends[2]) -- Ronaldo
        RedeemedCodes[code] = true
        print("[نجاح] تم فتح بكج الأساطير! حصلت على: ليونيل ميسي وكريستيانو رونالدو!")

    else
        print("[خطأ] الكود غير صحيح، يرجى التأكد من كتابته بشكل مضبوط.")
    end
end

-- ====================================================
-- 3. محاكي فتح البكجات (Pack Opener System)
-- ====================================================
function OpenPack(packName)
    print("\n--- جاري فتح بكج: " .. packName .. " ---")
    
    if packName == "Legendary_GOAT_Pack" then
        for _, player in ipairs(PlayersDatabase.Legends) do
            print("-> حصلت على اللاعب: " .. player.name .. " (الطاقة: " .. player.rating .. ") [" .. player.cardType .. "]")
        end
    elseif packName == "Egypt_Pack" then
        print("-> حصلت على جميع لاعبي منتخب مصر الأساسيين والاحتياط!")
    elseif packName == "FC_Barcelona_Pack" then
        print("-> حصلت على تشكيلة نادي برشلونة بالكامل!")
    else
        print("-> تم إضافه جميع لاعبي البكج " .. packName .. " إلى تشكيلتك.")
    end
end

-- ====================================================
-- 4. إعدادات الفيزيائية والحركات (Gameplay Mechanics)
-- ====================================================
GameplayEngine = {
    Controls = "PES_Touch_And_Buttons_Standard", -- نفس أسلوب تحكم ونظام بيس
    Physics = "Real_Ball_Physics_v2026",          -- حركة الكرة والفيزياء
    SkillMoves = {                                -- المهارات والحركات
        "Double Touch",
        "Marselle Turn",
        "Knuckle Shot",
        "Stunning Shot"
    }
}

function ShowEngineStatus()
    print("\n==========================================")
    print("اسم اللعبة: " .. GameSystem.Name)
    print("أسلوب التحكم: " .. GameplayEngine.Controls)
    print("المهارات المفعلة: " .. #GameplayEngine.SkillMoves .. " مهارات أصلية")
    print("==========================================\n")
end

-- ====================================================
-- تجربة الأكواد والبكجات (Testing)
-- ====================================================

-- عرض حالة اللعبة
ShowEngineStatus()

-- تجربة كود الكوينز
RedeemGiftCode("adham")

-- تجربة كود الأساطير
RedeemGiftCode("adham123")

-- تجربة فتح البكجات
OpenPack("Legendary_GOAT_Pack")
OpenPack("Egypt_Pack")
OpenPack("France_Pack")
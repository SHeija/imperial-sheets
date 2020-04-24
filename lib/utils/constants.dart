// Koodisto
// STATS
const WS = 'Weapon Skill';
const BS = 'Ballistic skill';
const S = 'Strength';
const T = 'Toughness';
const AG = 'Agility';
const INT = 'Intelligence';
const PER = 'Perception';
const WP = 'Willpower';
const FS = 'Fellowship';
const INF = 'Influence';

const ALL_STATS = [WS, BS, S, T, AG, INT, PER, WP, FS, INF];
const STAT_LIST = {'WS':WS, 'BS':BS, 'S':S, 'T':T, 'AG':AG, 'INT':INT, 'PER':PER, 'WP':WP, 'FS':FS, 'INF':INF};

// SKILLS
const acrobatics = 'Acrobatics';
const athletics = 'Athletics';
const awareness = 'Awareness';
const charm = 'Charm';
const command = 'Command';
const commerce = 'Commerce';
const commonLore = 'Common Lore';
const deceive = 'Deceive';
const dodge = 'Dodge';
const forbiddenLore = 'Forbidden Lore';
const inquiry = 'Inquiry';
const interrogation = 'Interrogation';
const intimidate = 'Intimidate';
const linguistics = 'Linguistics';
const logic = 'Logic';
const medicae = 'Medicae';
const navigateSurface = 'Navigate: Surface';
const navigateStellar = 'Navigate: Stellar';
const navigateWarp = 'Navigate: Warp';
const operateAeronautica = 'Operate: Aeronautica';
const operateSurface = 'Operate: Surface';
const operateVoidship = 'Operate: Voidship';
const parry = 'Parry';
const psyniscience = 'Psyniscience';
const scholasticLore = 'Scholastic Lore';
const scrutiny = 'Scrutiny';
const security = 'Security';
const sleighOfHand = 'Sleigh of Hand';
const stealth = 'Stealth';
const survival = 'Survival';
const techUse = 'Tech use';
const trade = 'Trade';
const ALL_SKILLS = [
  acrobatics,
  athletics,
  awareness,
  charm,
  command,
  commerce,
  commonLore,
  deceive,
  dodge,
  forbiddenLore,
  inquiry,
  interrogation,
  intimidate,
  linguistics,
  logic,
  medicae,
  navigateSurface,
  navigateStellar,
  navigateWarp,
  operateAeronautica,
  operateSurface,
  operateVoidship,
  parry,
  psyniscience,
  scholasticLore,
  scrutiny,
  security,
  sleighOfHand,
  stealth,
  survival,
  techUse,
  trade
];

const SKILL_LIST = {
  acrobatics:AG,
  athletics:S,
  awareness:PER,
  charm:FS,
  command:FS,
  commerce:INT,
  commonLore:INT,
  deceive:FS,
  dodge:AG,
  forbiddenLore:INT,
  inquiry:FS,
  interrogation:WP,
  intimidate:S,
  linguistics:INT,
  logic:INT,
  medicae:INT,
  navigateSurface:INT,
  navigateStellar:INT,
  navigateWarp:INT,
  operateAeronautica:AG,
  operateSurface:AG,
  operateVoidship:AG,
  parry:WS,
  psyniscience:PER,
  scholasticLore:INT,
  scrutiny:PER,
  security:INT,
  sleighOfHand:AG,
  stealth:AG,
  survival:PER,
  techUse:INT,
  trade:INT
};

// APTITUDES
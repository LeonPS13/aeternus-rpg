-- ============================================================
-- Aeternus RPG — Tabela de Magias
-- ============================================================

CREATE TABLE IF NOT EXISTS spells (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name          text        NOT NULL,
  name_en       text,
  level         integer     NOT NULL CHECK (level >= 0 AND level <= 9),
  school        text        NOT NULL,
  casting_time  text        NOT NULL,
  range         text        NOT NULL,
  components    text        NOT NULL,
  duration      text        NOT NULL,
  concentration boolean     NOT NULL DEFAULT false,
  ritual        boolean     NOT NULL DEFAULT false,
  description   text        NOT NULL,
  higher_levels text,
  classes       text[]      NOT NULL DEFAULT '{}',
  source        text        NOT NULL DEFAULT 'srd',
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE spells ENABLE ROW LEVEL SECURITY;

CREATE POLICY "spells_select" ON spells FOR SELECT USING (true);

CREATE INDEX IF NOT EXISTS spells_level_idx   ON spells (level);
CREATE INDEX IF NOT EXISTS spells_school_idx  ON spells (school);
CREATE INDEX IF NOT EXISTS spells_classes_idx ON spells USING GIN (classes);

-- ============================================================
-- PACOTE 1 — Truques (26) + 1º Círculo parcial (24) = 50
-- ============================================================

INSERT INTO spells (name, name_en, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

-- ── TRUQUES ─────────────────────────────────────────────────

('Feitiço de Ácido', 'Acid Splash', 0, 'evocation', '1 ação', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Você lança um projétil de ácido a uma criatura dentro do alcance. A criatura deve ser bem-sucedida em um teste de resistência de Destreza ou sofrer 1d6 de dano de ácido. Se o projétil puder atingir dois alvos adjacentes (a 1,5 m entre si), ambos devem realizar o teste.',
 'O dano aumenta para 2d6 no 5º nível, 3d6 no 11º e 4d6 no 17º.',
 ARRAY['sorcerer', 'wizard']),

('Proteção da Lâmina', 'Blade Ward', 0, 'abjuration', '1 ação', 'Pessoal', 'V, S', '1 rodada', false, false,
 'Você estende a mão e traça um símbolo de proteção no ar. Até o fim do seu próximo turno, você tem resistência contra dano cortante, contundente e perfurante causado por ataques com armas.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Toque Gélido', 'Chill Touch', 0, 'necromancy', '1 ação', '36 metros', 'V, S', '1 rodada', false, false,
 'Você cria uma mão espectral e esquelética no espaço de uma criatura. Faça um ataque mágico à distância. Se acertar, o alvo sofre 1d8 de dano necrótico e não pode recuperar pontos de vida até o início do seu próximo turno. Se o alvo for morto-vivo, ele também tem desvantagem nos testes de ataque contra você até o fim do seu próximo turno.',
 'O dano aumenta para 2d8 no 5º nível, 3d8 no 11º e 4d8 no 17º.',
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Luzes Dançantes', 'Dancing Lights', 0, 'evocation', '1 ação', '36 metros', 'V, S, M (fragmento de fósforo, pedra luminosa ou luz-da-lua)', 'Concentração, até 1 minuto', true, false,
 'Você cria até quatro luzes do tamanho de tochas que flutuam em qualquer lugar dentro do alcance. Elas podem ser combinadas em uma figura brilhante de humanoide de tamanho Médio. Como ação bônus, você pode mover as luzes até 18 metros.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Druídica', 'Druidcraft', 0, 'transmutation', '1 ação', '9 metros', 'V, S', 'Instantâneo', false, false,
 'Você sussurra os segredos da natureza e cria um dos seguintes efeitos: prevê o tempo local pelas próximas 24 horas; faz uma flor desabrochar, uma semente brotar ou uma folha abrir; cria um efeito sensorial inofensivo, como a brisa, o cheiro de flores ou o canto de um pássaro.',
 NULL,
 ARRAY['druid']),

('Explosão Eldritch', 'Eldritch Blast', 0, 'evocation', '1 ação', '36 metros', 'V, S', 'Instantâneo', false, false,
 'Um feixe de energia crepitante golpeia uma criatura dentro do alcance. Faça um ataque mágico à distância. Se acertar, o alvo sofre 1d10 de dano de força.',
 'A magia cria mais de um feixe em níveis mais altos: 2 feixes no 5º nível, 3 no 11º e 4 no 17º. Você pode direcionar os feixes para o mesmo alvo ou para alvos diferentes.',
 ARRAY['warlock']),

('Raio de Fogo', 'Fire Bolt', 0, 'evocation', '1 ação', '36 metros', 'V, S', 'Instantâneo', false, false,
 'Você lança um mísero de fogo a uma criatura ou objeto dentro do alcance. Faça um ataque mágico à distância. Se acertar, o alvo sofre 1d10 de dano de fogo. Objetos inflamáveis não carregados pegam fogo.',
 'O dano aumenta para 2d10 no 5º nível, 3d10 no 11º e 4d10 no 17º.',
 ARRAY['sorcerer', 'wizard']),

('Amigos', 'Friends', 0, 'enchantment', '1 ação', 'Pessoal', 'S, M (maquiagem aplicada no rosto)', 'Concentração, até 1 minuto', true, false,
 'Enquanto a magia durar, você tem vantagem em todos os testes de Carisma direcionados a uma criatura não-hostil de sua escolha. Quando a magia terminar, a criatura percebe que você usou magia para influenciá-la e pode se tornar hostil.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Orientação', 'Guidance', 0, 'divination', '1 ação', 'Toque', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Você toca uma criatura voluntária. Uma vez antes da magia terminar, a criatura pode rolar um d4 e adicionar o resultado a uma verificação de habilidade de sua escolha, antes ou depois de realizá-la.',
 NULL,
 ARRAY['cleric', 'druid']),

('Luz', 'Light', 0, 'evocation', '1 ação', 'Toque', 'V, M (um vaga-lume ou musgo luminoso)', '1 hora', false, false,
 'Você toca um objeto de até 3 metros em qualquer dimensão. O objeto emite luz brilhante num raio de 6 metros e penumbra por mais 6 metros. Cobri-lo com algo opaco bloqueia a luz. Se o objeto for carregado por um ser hostil, ele pode fazer um teste de resistência de Destreza para negar o efeito.',
 NULL,
 ARRAY['bard', 'cleric', 'sorcerer', 'wizard']),

('Mão do Mago', 'Mage Hand', 0, 'conjuration', '1 ação', '9 metros', 'V, S', '1 minuto', false, false,
 'Uma mão espectral flutuante aparece em um ponto à sua escolha. Ela pode manipular objetos leves (até 5 kg), abrir portas ou recipientes, guardar ou recuperar itens de um contêiner aberto, ou despejar o conteúdo de um frasco. Não pode atacar nem ativar itens mágicos.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Conserto', 'Mending', 0, 'transmutation', '1 minuto', 'Toque', 'V, S, M (dois ímãs)', 'Instantâneo', false, false,
 'Esta magia repara um único fragmento ou ruptura em um objeto que você toque — uma corrente quebrada, um cálice rachado, um manto rasgado. O dano reparado não pode ser maior que 30 cm em qualquer dimensão. A magia pode reparar fisicamente um objeto mágico, mas não restaura sua magia.',
 NULL,
 ARRAY['bard', 'cleric', 'druid', 'sorcerer', 'wizard']),

('Mensagem', 'Message', 0, 'transmutation', '1 ação', '36 metros', 'V, S, M (pedaço curto de fio de cobre)', '1 rodada', false, false,
 'Você aponta para uma criatura e sussurra uma mensagem. Apenas ela ouve e pode responder em sussurros que somente você ouvirá. A magia atravessa a maioria das barreiras, mas é bloqueada por 30 cm de pedra, 2 cm de metal ou uma fina camada de chumbo.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Ilusão Menor', 'Minor Illusion', 0, 'illusion', '1 ação', '9 metros', 'S, M (pedaço de lã)', '1 minuto', false, false,
 'Você cria um som ou imagem de um objeto que persiste por até 1 minuto. Um som pode variar do sussurro ao grito. Uma imagem ocupa até 1 m³. Criaturas podem examinar a ilusão com Inteligência (Investigação) CD 14 para reconhecê-la como falsa.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Jato de Veneno', 'Poison Spray', 0, 'conjuration', '1 ação', '3 metros', 'V, S', 'Instantâneo', false, false,
 'Você estende a mão em direção a uma criatura visível e projeta um jato de gás nocivo. A criatura deve ser bem-sucedida em um teste de resistência de Constituição ou sofrer 1d12 de dano de veneno.',
 'O dano aumenta para 2d12 no 5º nível, 3d12 no 11º e 4d12 no 17º.',
 ARRAY['druid', 'sorcerer', 'warlock', 'wizard']),

('Prestidigitação', 'Prestidigitation', 0, 'transmutation', '1 ação', '3 metros', 'V, S', 'Até 1 hora', false, false,
 'Truques mágicos simples que conjuradores iniciantes praticam. Você pode criar um efeito sensorial inofensivo; acender ou apagar uma chama; limpar ou sujar um objeto pequeno; aquecer, resfriar ou aromatizar até 500 ml de material não-vivo; criar uma marca ou símbolo; criar uma pequena bugiganga ou imagem ilusória efêmera na palma da mão.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Produzir Chama', 'Produce Flame', 0, 'conjuration', '1 ação', 'Pessoal', 'V, S', '10 minutos', false, false,
 'Uma chama aparece em sua mão. Ela ilumina com luz brilhante num raio de 3 metros e penumbra por mais 3 metros. Como ação, você pode arremessar a chama a uma criatura a até 9 metros (ataque mágico à distância), causando 1d8 de dano de fogo; a chama se apaga após o arremesso.',
 'O dano aumenta para 2d8 no 5º nível, 3d8 no 11º e 4d8 no 17º.',
 ARRAY['druid']),

('Raio de Gelo', 'Ray of Frost', 0, 'evocation', '1 ação', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Um raio gelado de luz azul-branca se dirige a uma criatura. Faça um ataque mágico à distância. Se acertar, o alvo sofre 1d8 de dano de frio e sua velocidade é reduzida em 3 metros até o início do seu próximo turno.',
 'O dano aumenta para 2d8 no 5º nível, 3d8 no 11º e 4d8 no 17º.',
 ARRAY['sorcerer', 'wizard']),

('Resistência', 'Resistance', 0, 'abjuration', '1 ação', 'Toque', 'V, S, M (manto em miniatura)', 'Concentração, até 1 minuto', true, false,
 'Você toca uma criatura voluntária. Uma vez antes da magia terminar, a criatura pode rolar um d4 e adicionar o resultado a um teste de resistência de sua escolha, antes ou depois de realizá-lo.',
 NULL,
 ARRAY['cleric', 'druid']),

('Chama Sagrada', 'Sacred Flame', 0, 'evocation', '1 ação', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Radiância flamejante desce sobre uma criatura visível. O alvo deve ser bem-sucedido em um teste de resistência de Destreza ou sofrer 1d8 de dano radiante. O alvo não se beneficia de cobertura para esse teste.',
 'O dano aumenta para 2d8 no 5º nível, 3d8 no 11º e 4d8 no 17º.',
 ARRAY['cleric']),

('Clava Mágica', 'Shillelagh', 0, 'transmutation', '1 ação bônus', 'Toque', 'V, S, M (visco, noz e o porrete ou cajado que é a base da magia)', 'Concentração, até 1 minuto', true, false,
 'A madeira de um porrete ou cajado que você esteja segurando é imbuída com poder natural. Você usa seu modificador de conjuração em vez de Força para os testes de ataque e dano com essa arma, e o dado de dano passa a ser 1d8. A arma conta como mágica.',
 NULL,
 ARRAY['druid']),

('Toque Elétrico', 'Shocking Grasp', 0, 'evocation', '1 ação', 'Toque', 'V, S', 'Instantâneo', false, false,
 'Relâmpago salta de sua mão para uma criatura que você tente tocar. Faça um ataque mágico corpo a corpo. Você tem vantagem se o alvo usar armadura de metal. Se acertar, o alvo sofre 1d8 de dano de raio e não pode usar reações até o início do seu próximo turno.',
 'O dano aumenta para 2d8 no 5º nível, 3d8 no 11º e 4d8 no 17º.',
 ARRAY['sorcerer', 'wizard']),

('Poupar os Moribundos', 'Spare the Dying', 0, 'necromancy', '1 ação', 'Toque', 'V, S', 'Instantâneo', false, false,
 'Você toca uma criatura viva com 0 pontos de vida. A criatura fica estável. Esta magia não tem efeito em mortos-vivos e construtos.',
 NULL,
 ARRAY['cleric']),

('Taumaturgia', 'Thaumaturgy', 0, 'transmutation', '1 ação', '9 metros', 'V', 'Até 1 minuto', false, false,
 'Você manifesta um sinal menor de poder sobrenatural. Pode criar um dos seguintes efeitos: sua voz ressoa com volume três vezes maior; chamas tremulam ou mudam de cor; tremores surgem no solo; seus olhos brilham; portas se abrem ou fecham à sua vontade; um símbolo mágico brilha em sua testa. Você pode ter até três efeitos simultâneos ativos.',
 NULL,
 ARRAY['cleric']),

('Golpe Certeiro', 'True Strike', 0, 'divination', '1 ação', '9 metros', 'S', 'Concentração, até 1 rodada', true, false,
 'Você estende a mão e aponta para um alvo. Sua magia lhe concede uma percepção das defesas do alvo. Em seu próximo turno, você tem vantagem no primeiro teste de ataque contra o alvo, desde que a magia ainda esteja ativa.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Zombaria Viciosa', 'Vicious Mockery', 0, 'enchantment', '1 ação', '18 metros', 'V', 'Instantâneo', false, false,
 'Você lança uma torrente de insultos imbuídos de poder encantador. A criatura que os ouça deve ser bem-sucedida em um teste de resistência de Sabedoria ou sofrer 1d4 de dano psíquico e ter desvantagem no próximo teste de ataque antes do fim do seu próximo turno.',
 'O dano aumenta para 2d4 no 5º nível, 3d4 no 11º e 4d4 no 17º.',
 ARRAY['bard']),

-- ── 1º CÍRCULO ───────────────────────────────────────────────

('Alarme', 'Alarm', 1, 'abjuration', '1 minuto', '9 metros', 'V, S, M (sino e fio de prata)', '8 horas', false, true,
 'Você define uma zona de alerta contra intrusos em torno de uma porta, janela ou área. Quando uma criatura de tamanho Miúdo ou maior entrar ou tocar a área, o alarme soa. Pode ser mental (audível apenas por você) ou sonoro (audível a 18 metros). Você pode designar criaturas que não ativam o alarme.',
 NULL,
 ARRAY['ranger', 'wizard']),

('Amizade com Animais', 'Animal Friendship', 1, 'enchantment', '1 ação', '9 metros', 'V, S, M (alimento)', '24 horas', false, false,
 'Você convence um animal de que não representa uma ameaça. O alvo deve ter Inteligência 3 ou menos e fracassar em um teste de resistência de Sabedoria para ser encantado por 24 horas. Ao fim, ele sabe que foi encantado.',
 'Cada slot acima do 1º afeta um animal adicional.',
 ARRAY['bard', 'druid', 'ranger']),

('Maldição', 'Bane', 1, 'enchantment', '1 ação', '9 metros', 'V, S, M (gota de sangue)', 'Concentração, até 1 minuto', true, false,
 'Até três criaturas visíveis dentro do alcance devem fazer testes de resistência de Carisma. As que fracassarem subtraem 1d4 de todos os testes de ataque e de resistência enquanto a magia durar.',
 'Cada slot acima do 1º afeta uma criatura adicional.',
 ARRAY['bard', 'cleric']),

('Bênção', 'Bless', 1, 'enchantment', '1 ação', '9 metros', 'V, S, M (água benta)', 'Concentração, até 1 minuto', true, false,
 'Você abençoa até três criaturas à sua escolha dentro do alcance. Sempre que uma criatura alvo fizer um teste de ataque ou de resistência antes da magia terminar, ela rola um d4 adicional e adiciona o resultado ao teste.',
 'Cada slot acima do 1º abençoa uma criatura adicional.',
 ARRAY['cleric', 'paladin']),

('Mãos em Chamas', 'Burning Hands', 1, 'evocation', '1 ação', 'Pessoal (cone de 4,5 metros)', 'V, S', 'Instantâneo', false, false,
 'Um manto fino de fogo sai das pontas dos seus dedos. Cada criatura num cone de 4,5 metros sofre 3d6 de dano de fogo, ou metade com um teste de resistência de Destreza bem-sucedido. Objetos inflamáveis na área pegam fogo.',
 '+1d6 de dano de fogo para cada slot acima do 1º.',
 ARRAY['sorcerer', 'wizard']),

('Enfeitiçar Pessoa', 'Charm Person', 1, 'enchantment', '1 ação', '9 metros', 'V, S', '1 hora', false, false,
 'Você tenta encantar um humanoide visível. Ele faz um teste de resistência de Sabedoria com vantagem se você ou seus aliados o estiverem ameaçando. Se fracassar, será encantado — o considera um amigo próximo — até a magia terminar ou até ser prejudicado. Ao fim, ele sabe que foi encantado.',
 'Cada slot acima do 1º afeta um humanoide adicional (a 9 m entre si).',
 ARRAY['bard', 'druid', 'sorcerer', 'warlock', 'wizard']),

('Curar Ferimentos', 'Cure Wounds', 1, 'evocation', '1 ação', 'Toque', 'V, S', 'Instantâneo', false, false,
 'Uma criatura que você toque recupera 1d8 + seu modificador de habilidade de conjuração pontos de vida. Sem efeito em mortos-vivos e construtos.',
 '+1d8 de cura para cada slot acima do 1º.',
 ARRAY['bard', 'cleric', 'druid', 'paladin', 'ranger']),

('Detectar Magia', 'Detect Magic', 1, 'divination', '1 ação', 'Pessoal', 'V, S', 'Concentração, até 10 minutos', true, true,
 'Você percebe a presença de magia num raio de 9 metros. Pode usar sua ação para ver uma aura ao redor de objetos ou criaturas visíveis que contenham magia, e aprender a escola de magia de cada um.',
 NULL,
 ARRAY['bard', 'cleric', 'druid', 'paladin', 'ranger', 'sorcerer', 'wizard']),

('Disfarçar-se', 'Disguise Self', 1, 'illusion', '1 ação', 'Pessoal', 'V, S', '1 hora', false, false,
 'Você faz sua aparência parecer diferente, incluindo roupas, armadura e equipamentos. Pode parecer até 30 cm mais alto ou mais baixo. A ilusão não resiste ao toque. Criaturas podem examinar a ilusão com Inteligência (Investigação) contra sua CD de magia para reconhecê-la.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Favor Divino', 'Divine Favor', 1, 'evocation', '1 ação bônus', 'Pessoal', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Suas armas de ataque causam 1d4 adicional de dano radiante quando acertarem um alvo enquanto a magia durar.',
 NULL,
 ARRAY['paladin']),

('Chama Feérica', 'Faerie Fire', 1, 'evocation', '1 ação', '18 metros', 'V', 'Concentração, até 1 minuto', true, false,
 'Cada objeto num cubo de 6 metros dentro do alcance é delineado em luz azul, verde ou violeta. Criaturas na área que falhem num teste de resistência de Destreza também ficam delineadas e emitem luz fraca num raio de 3 metros. Ataques contra criaturas afetadas têm vantagem; elas não se beneficiam de invisibilidade.',
 NULL,
 ARRAY['bard', 'druid']),

('Vida Falsa', 'False Life', 1, 'necromancy', '1 ação', 'Pessoal', 'V, S, M (um pouquinho de álcool ou destilado)', '1 hora', false, false,
 'Fortalecendo-se com uma imitação sombria da vitalidade, você ganha 1d4+4 pontos de vida temporários.',
 '+5 pontos de vida temporários para cada slot acima do 1º.',
 ARRAY['sorcerer', 'wizard']),

('Queda de Pena', 'Feather Fall', 1, 'transmutation', '1 reação, quando você ou uma criatura a 18 m cair', '18 metros', 'V, M (pluma ou pena)', '1 minuto', false, false,
 'Escolha até cinco criaturas em queda dentro do alcance. A velocidade de queda de cada uma é reduzida a 18 metros por rodada até a magia terminar. Criaturas que aterrissem antes do fim não sofrem dano de queda.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Baga Salutar', 'Goodberry', 1, 'transmutation', '1 ação', 'Toque', 'V, S, M (ramo de visco)', 'Instantâneo', false, false,
 'Até dez bagas imbuídas de magia aparecem em sua mão. Uma criatura pode usar uma ação para comer uma baga e recuperar 1 ponto de vida; cada baga também sustenta uma criatura por um dia. As bagas se perdem ao fim do seu próximo descanso longo.',
 NULL,
 ARRAY['druid', 'ranger']),

('Palavra de Cura', 'Healing Word', 1, 'evocation', '1 ação bônus', '18 metros', 'V', 'Instantâneo', false, false,
 'Uma criatura visível dentro do alcance recupera 1d4 + seu modificador de habilidade de conjuração pontos de vida. Sem efeito em mortos-vivos e construtos.',
 '+1d4 de cura para cada slot acima do 1º.',
 ARRAY['bard', 'cleric', 'druid']),

('Represália Infernal', 'Hellish Rebuke', 1, 'evocation', '1 reação, ao receber dano de criatura visível a 18 m', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Você aponta o dedo e a criatura que o feriu é envolta em chamas infernais. A criatura faz um teste de resistência de Destreza, sofrendo 2d10 de dano de fogo se fracassar ou metade se tiver êxito.',
 '+1d10 de dano de fogo para cada slot acima do 1º.',
 ARRAY['warlock']),

('Heroísmo', 'Heroism', 1, 'enchantment', '1 ação', 'Toque', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Uma criatura voluntária fica imune ao efeito amedrontado e ganha pontos de vida temporários iguais ao seu modificador de conjuração no início de cada turno. Quando a magia terminar, o alvo perde os pontos de vida temporários restantes.',
 'Uma criatura adicional por slot acima do 1º.',
 ARRAY['bard', 'paladin']),

('Marca do Caçador', 'Hunter''s Mark', 1, 'divination', '1 ação bônus', '27 metros', 'V', 'Concentração, até 1 hora', true, false,
 'Você marca uma criatura visível como sua presa. Até a magia terminar, você causa 1d6 extra de dano sempre que acertar o alvo com um ataque de arma, e tem vantagem em testes de Percepção e Sobrevivência para encontrá-lo ou rastreá-lo.',
 'Com slot do 3º ou 4º, duração sobe para 8 horas. Com slot do 5º ou superior, 24 horas.',
 ARRAY['ranger']),

('Infligir Ferimentos', 'Inflict Wounds', 1, 'necromancy', '1 ação', 'Toque', 'V, S', 'Instantâneo', false, false,
 'Faça um ataque mágico corpo a corpo contra uma criatura que você possa alcançar. Se acertar, o alvo sofre 3d10 de dano necrótico.',
 '+1d10 de dano necrótico para cada slot acima do 1º.',
 ARRAY['cleric']),

('Armadura Mágica', 'Mage Armor', 1, 'abjuration', '1 ação', 'Toque', 'V, S, M (pedaço de couro curtido)', '8 horas', false, false,
 'Você toca uma criatura voluntária sem armadura. Uma força protetora mágica a envolve. A CA base do alvo se torna 13 + seu modificador de Destreza. A magia termina se o alvo equipar uma armadura ou se você dispensá-la.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Míssil Mágico', 'Magic Missile', 1, 'evocation', '1 ação', '36 metros', 'V, S', 'Instantâneo', false, false,
 'Você cria três dardos brilhantes de energia mágica. Cada dardo acerta automaticamente uma criatura visível dentro do alcance, causando 1d4+1 de dano de força. Os dardos podem atingir o mesmo alvo ou alvos diferentes.',
 '+1 dardo para cada slot acima do 1º.',
 ARRAY['sorcerer', 'wizard']),

('Escudo', 'Shield', 1, 'abjuration', '1 reação, ao ser atingido por ataque ou alvo de Míssil Mágico', 'Pessoal', 'V, S', '1 rodada', false, false,
 'Uma barreira invisível de força mágica surge e protege você. Até o início de seu próximo turno, você tem +5 na CA, inclusive contra o ataque que desencadeou a magia, e não sofre dano de Míssil Mágico.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Adormecer', 'Sleep', 1, 'enchantment', '1 ação', '27 metros', 'V, S, M (pitada de areia fina, pétalas de rosa ou um grilo)', 'Concentração, até 1 minuto', true, false,
 'Role 5d8; o total é a quantidade de pontos de vida de criaturas que esta magia pode adormecer. As criaturas num raio de 6 metros dentro do alcance são afetadas em ordem crescente de PV atuais. Criaturas adormecidas ficam inconscientes até a magia terminar, sofrerem dano ou alguém as acordar.',
 '+2d8 por slot acima do 1º.',
 ARRAY['bard', 'sorcerer', 'wizard']),

('Onda de Trovão', 'Thunderwave', 1, 'evocation', '1 ação', 'Pessoal (cubo de 4,5 metros)', 'V, S', 'Instantâneo', false, false,
 'Uma onda de força trovejante sai de você. Cada criatura num cubo de 4,5 metros deve fazer um teste de resistência de Constituição, sofrendo 2d8 de dano de trovão e sendo empurrada 3 metros se fracassar, ou metade do dano sem ser empurrada se tiver êxito. O estrondo é audível a 300 metros.',
 '+1d8 de dano de trovão para cada slot acima do 1º.',
 ARRAY['bard', 'druid', 'sorcerer', 'wizard']);

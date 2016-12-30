unit ufpgCadProcessoSuitTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests;

const
  CS_CAMINHO_TESTE = 'Cadastro de Processo\';

  CS_COMPETENCIA_1 = 'Compet�ncia 1 - C�vel\';
  CS_COMPETENCIA_2 = 'Compet�ncia 2 - Fam�lia e Sucess�es\';
  CS_COMPETENCIA_3 = 'Compet�ncia 3 - Registros P�blicos\';
  CS_COMPETENCIA_4 = 'Compet�ncia 4 - Inf�ncia e Juventude C�vel\';
  CS_COMPETENCIA_5 = 'Compet�ncia 5 - Execu��o Contra Fazenda\';
  CS_COMPETENCIA_7 = 'Compet�ncia 7 - Acidentes do Trabalho\';
  CS_COMPETENCIA_8 = 'Compet�ncia 8 - Juizado Especial C�vel\';
  CS_COMPETENCIA_9 = 'Compet�ncia 9 - Criminal\';
  CS_COMPETENCIA_10 = 'Compet�ncia 10 - Juizado Especial Criminal\';
  CS_COMPETENCIA_11 = 'Compet�ncia 11 - J�ri\';
  CS_COMPETENCIA_12 = 'Compet�ncia 12 - Precat�rias C�veis\';
  CS_COMPETENCIA_18 = 'Compet�ncia 18 - Juizado Itinerante\';
  CS_COMPETENCIA_19 = 'Compet�ncia 19 - DIPO - Depto de Inqu�ritos Policiais\';
  CS_COMPETENCIA_27 = 'Compet�ncia 27 - Juizado Criminal - Viol�ncia Dom�stica\';
  CS_COMPETENCIA_130 = 'Compet�ncia 130 - Juizado Especial do Torcedor - Criminal\';
  CS_COMPETENCIA_144 = 'Compet�ncia 144 - Criminal-SANCTVS\';
  CS_COMPETENCIA_16 = 'Compet�ncia 16 - Execu��o Criminal\';
  CS_COMPETENCIA_69 = 'Compet�ncia 69 - Crimes Falimentares\';
  CS_COMPETENCIA_21 = 'Compet�ncia 21 - Fal�ncia e Recupera��o Judicial/Extrajud\';
  CS_COMPETENCIA_26 = 'Compet�ncia 26 - Inf�ncia e Juventude Infracional\';
  CS_COMPETENCIA_33 = 'Compet�ncia 33 - Anexos dos Juizados\';
  CS_COMPETENCIA_34 = 'Compet�ncia 34 - CIC - Juizado Especial C�vel\';
  CS_COMPETENCIA_35 = 'Compet�ncia 35 - Fazenda P�blica Municipal\';
  CS_COMPETENCIA_36 = 'Compet�ncia 36 - Fazenda P�blica Estadual\';
  CS_COMPETENCIA_37 = 'Compet�ncia 37 - Fazenda P�blica Federal\';
  CS_COMPETENCIA_38 = 'Compet�ncia 38 - Especial Relativo ao Idoso\';
  CS_COMPETENCIA_145 = 'Compet�ncia 145 - Corregedoria dos Pres�dios\';
  CS_COMPETENCIA_46 = 'Compet�ncia 46 - Juizado Especial da Fazenda Municipal\';
  CS_COMPETENCIA_47 = 'Compet�ncia 47 - Juizado Especial da Fazenda Estadual\';
  CS_COMPETENCIA_63 = 'Compet�ncia 63 - Execu��o Fiscal Estadual\';
  CS_COMPETENCIA_64 = 'Compet�ncia 64 - Execu��o Fiscal Municipal\';
  CS_COMPETENCIA_65 = 'Compet�ncia 65 - Execu��o Fiscal Federal\';
  CS_COMPETENCIA_107 = 'Compet�ncia 107 - Inf�ncia e Juventude - Execu��o\';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin

    {*************************************************************************
                      PROCESSOS C�vel - COMPET�NCIA 1
    *************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_1 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1258', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_1 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1261', 1, True));
    //--------------

    {*************************************************************************
                      PROCESSOS Fam�lia e Sucess�es - COMPET�NCIA 2
    *************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_2 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse2258', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_2 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse2261', 1, True));
    //--------------
    {*************************************************************************
                      PROCESSOS Registros P�blicos - COMPET�NCIA 3
    *************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_3 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse3258', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_3 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse3261', 1, True));
    //--------------

    {*************************************************************************
                      PROCESSOS Inf�ncia e Juventude C�vel - COMPET�NCIA 4
    *************************************************************************}
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_4 + 'Classe 1265',TffpgCadProcessoTests.Create('TestarCadastroProcesso'  , '  TestarCadProcessoClasse41265'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_4 + 'Classe 1265',TffLimparVariaveisTests.Create('LimparVariaveis'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_4 + 'Classe 1266',TffpgCadProcessoTests.Create('TestarCadastroProcesso'  , 'TestarCadProcessoClasse41266'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_4 + 'Classe 1266',TffLimparVariaveisTests.Create('LimparVariaveis'));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_4 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse4258', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_4 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse4261', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_4 + 'Classe 1451',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse41451', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_4 + 'Classe 1455',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse41455', 1, True));
    //--------------

    {*************************************************************************
                      PROCESSOS Acidentes do Trabalho - COMPET�NCIA 5
    *************************************************************************}
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_5 + 'Classe 1265',TffpgCadProcessoTests.Create('TestarCadastroProcesso'  , '  TestarCadProcessoClasse51265'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_5 + 'Classe 1265',TffLimparVariaveisTests.Create('LimparVariaveis'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_5 + 'Classe 1266',TffpgCadProcessoTests.Create('TestarCadastroProcesso'  , 'TestarCadProcessoClasse51266'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_5 + 'Classe 1266',TffLimparVariaveisTests.Create('LimparVariaveis'));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_5 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse5258', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_5 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse5261', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_5 + 'Classe 1116',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse51116', 1, True));
    //--------------

    {*************************************************************************
                      PROCESSOS Juizado Especial C�vel - COMPET�NCIA 7
    *************************************************************************}
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_7 + 'Classe 1265',TffpgCadProcessoTests.Create('TestarCadastroProcesso'  , 'TestarCadProcessoClasse71265'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_7 + 'Classe 1265',TffLimparVariaveisTests.Create('LimparVariaveis'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_7 + 'Classe 1266',TffpgCadProcessoTests.Create('TestarCadastroProcesso'  , 'TestarCadProcessoClasse71266'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_7 + 'Classe 1266',TffLimparVariaveisTests.Create('LimparVariaveis'));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_7 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse7258', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_7 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse7261', 1, True));
    //--------------

    {*************************************************************************
                      PROCESSOS AREA CRIMINAL - COMPET�NCIA 8
    *************************************************************************}
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_8 + 'Classe 1265', TffpgCadProcessoTests.Create('TestarCadastroProcesso'  , 'TestarCadProcessoClasse81265'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_8 + 'Classe 1265',TffLimparVariaveisTests.Create('LimparVariaveis'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_8 + 'Classe 1266',TffpgCadProcessoTests.Create('TestarCadastroProcesso'  , 'TestarCadProcessoClasse81266'));
    //  RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_8 + 'Classe 1266',TffLimparVariaveisTests.Create('LimparVariaveis'));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_8 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse8258', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_8 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse8261', 1, True));
    //--------------


    {*************************************************************************
                      PROCESSOS AREA CRIMINAL - COMPET�NCIA 9
    *************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 275',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9275', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 278',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9278', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 279',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9279', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 280',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9280', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 282',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9282', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 283',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9283', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 287',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9287', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 288',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9288', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 289',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9289', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 293',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9293', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 294',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9294', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 295',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9295', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 297',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9297', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 300',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9300', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 302',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9302', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9307', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 309',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9309', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 310',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9310', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 311',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9311', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 313',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9313', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 314',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9314', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 326',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9326', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9335', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 355',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9355', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 1268',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse91268', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 1710',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse91710', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 1733',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse91733', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 10943',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse910943', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 10944',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse910944', 1, True));
    //--------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_9 + 'Classe 10967',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse910967', 1, True));

  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 10
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 275',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10275', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 278',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10278', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 279',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10279', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 280',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10280', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 287',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10287', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 288',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10288', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 289',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10289', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 293',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10293', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 294',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10294', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 295',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10295', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 297',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10297', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 300',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10300', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 302',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10302', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10307', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 309',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10309', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 310',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10310', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 313',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10313', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 326',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10326', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10335', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 355',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse10355', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 1463',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse101463', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 1733',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse101733', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 10944',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1010944', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_10 + 'Classe 10967',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1010967', 1, True));

  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 27
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 275',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27275', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 278',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27278', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 279',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27279', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 280',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27280', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 283',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27283', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 288',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27288', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 289',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27289', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 295',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27295', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 297',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27297', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 302',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27302', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27307', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 309',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27309', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 310',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27310', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 311',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27311', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 313',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27313', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 314',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27314', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 326',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27326', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27335', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 355',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse27355', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 1268',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse271268', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 1710',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse271710', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 1733',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse271733', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_27 + 'Classe 10943',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse2710943', 1, True));

  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 27
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 275',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130275', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 278',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130278', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 279',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130279', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 280',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130280', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 283',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130283', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130307', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 309',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130309', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 313',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130313', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 326',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130326', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130335', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 355',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse130355', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 1733',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1301733', 1, True));
    //-------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_130 + 'Classe 10944',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarCadProcessoClasse13010944',
      1, True));

  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 144
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 278',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144278', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 279',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144279', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 280',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144280', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 283',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144283', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144307', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 309',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144309', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 310',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144310', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 311',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144311', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 313',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144313', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 314',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144314', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 326',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144326', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144335', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 355',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse144355', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 1710',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1441710', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 1733',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1441733', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 10943',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarCadProcessoClasse14410943',
      1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_144 + 'Classe 10967',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarCadProcessoClasse14410967',
      1, True));

  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 19
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 275',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19275', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 278',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19278', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 279',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19279', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 280',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19280', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 282',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19282', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 283',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19283', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 287',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19287', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 288',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19288', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 289',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19289', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 293',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19293', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 294',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19294', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 295',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19295', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 297',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19297', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 300',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19300', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 302',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19302', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19307', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 309',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19309', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 310',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19310', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 311',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19311', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 313',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19313', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 314',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19314', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 326',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19326', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19335', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 355',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19355', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 386',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse19386', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 1268',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse191268', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 1710',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse191710', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 1733',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse191733', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 10943',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1910943', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_19 + 'Classe 10944',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1910944', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 16
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_16 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse16307', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_16 + 'Classe 355',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse16355', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_16 + 'Classe 386',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse16386', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_16 + 'Classe 1710',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse161710', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_16 + 'Classe 1714',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse161714', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_16 + 'Classe 11399',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1611399', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 69
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 278',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69278', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 279',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69279', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 280',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69280', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69307', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 309',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69309', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 310',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69310', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 313',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69313', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 314',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69314', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 326',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse69326', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 1733',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse691733', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_69 + 'Classe 10943',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse6910943', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 21
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_21 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse21258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_21 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse21261', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 26
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_26 + 'Classe 1461',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse261461', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_26 + 'Classe 1462',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse261462', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_26 + 'Classe 1463',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse261463', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_26 + 'Classe 1464',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse261464', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_26 + 'Classe 1465',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse261465', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_26 + 'Classe 1474',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse261474', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_26 + 'Classe 1478',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse261478', 1, True));
  {*****************************************************************************
                       PROCESSOS J�RI - COMPET�NCIA 11
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe279',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11279', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe280',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11280', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe282',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11282', 1, True));
    //---------------------
    //    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe292',
    //      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarCadProcessoClasse11292', 1, True));
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11307', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe309',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11309', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe310',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11310', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe311',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11311', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe313',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11313', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe314',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11314', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe326',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11326', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11335', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe355',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse11355', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe1268',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse111268', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe1710',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse111710', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_11 + 'Classe1733',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse111733', 1, True));
    //    //---------------------

      {*****************************************************************************
                           PROCESSOS PRACET�RIAS C�VEIS  - COMPET�NCIA 12
      *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_12 + 'Classe261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse12261', 1, True));
      {*****************************************************************************
                           PROCESSOS JUIZADO ITINERANTE  - COMPET�NCIA 18
      *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_18 + 'Classe258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse18258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_18 + 'Classe261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse18261', 1, True));
      {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 33
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_33 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse33261', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_33 + 'Classe 335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse33335', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 34
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_34 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse34261', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_34 + 'Classe 335',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse34335', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 35
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_35 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse35258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_35 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse35261', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 36
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_36 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse36258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_36 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse36261', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 37
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_37 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse37258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_37 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse37261', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 38
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_38 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse38261', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_38 + 'Classe 10967',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse3810967', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 145
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_145 + 'Classe 307',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse145307', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_145 + 'Classe 1710',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1451710', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 46
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_46 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse46258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_46 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse46261', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 47
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_47 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse47258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_47 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse47261', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 63
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_63 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse63258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_63 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse63261', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_63 + 'Classe 1116',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse631116', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 64
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_64 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse64258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_64 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse64261', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_64 + 'Classe 1116',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse641116', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 65
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_65 + 'Classe 258',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse65258', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_65 + 'Classe 261',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse65261', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_65 + 'Classe 1116',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse651116', 1, True));
  {*****************************************************************************
                       PROCESSOS AREA CRIMINAL - COMPET�NCIA 107
  *****************************************************************************}
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_107 + 'Classe 1465',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1071465', 1, True));
    //---------------------
    RegisterTest(CS_CAMINHO_TESTE + CS_COMPETENCIA_107 + 'Classe 1478',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse1071478', 1, True));
  end;

end.


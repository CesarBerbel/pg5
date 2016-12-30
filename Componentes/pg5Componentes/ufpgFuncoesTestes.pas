unit ufpgFuncoesTestes;

  {*************************************************
  **************************************************
  * 01/04/2015 - cesar.almeida - SALT: 172993/20/2 *
  **************************************************
  * Unit uspjFuncoesTestes criada para reunir as   *
  * procedures, constantes, fun��es e vari�veis    *
  * usadas em mais de uma unit de teste.           *
  **************************************************
  * �ndice:                                        *
  * - Atualiza��o                                  *
  * - Convers�o                                    *
  * - Gera��o                                      *
  * - Sele��o                                      *
  * - Data                                         *
  * - Limpeza                                      *
  * - Executar                                     *
  * - Processo                                     *
  * - Cria��o                                      *
  *                                                *
  **************************************************
  *************************************************}

interface

uses
  Windows, SysUtils, Classes, Forms, dcntree, dcinfotree, dxBar, dxBarExtItems,
  uspTestCase, spdxBar, ComCtrls, uspExcecao, ufpgConstanteSQLTests, ShellAPI,
  ufpgGUITestCase, uspGUITestCase, Registry, TLHelp32, IdHTTP, ufpgEditor,
  Dialogs, ufpgCadProcesso, ufpgResultadoDistribuicao, Controls, IniFiles,
  ufpgConstanteTests, ufpgVariaveisTestes, uspForm, Messages, ufpgFuncoesSQLTests;

type
  TCallBack = procedure of object;

var
  FsNumeroCNPJ: string;
  FsNumeroCPF: string;
  handle: THandle;
  Programa, Desktop, oParams, Document: variant;
  FsLocalArquivo: string;

const
  nomePG = 'nomeServidor=fpgServidor.fpgServidorDM';
  IDPG = 'GUIDServidor={42A9E80A-670D-459D-B20E-E41F9B3AD880}';
  nomePRO = 'NomeServidor=proServidor.proServidorDM';
  IDPRO = 'GUIDServidor={506C7E11-90A0-452D-9012-D1394F0943E7}';
  nomeARC = 'NomeSErvidor = arcServidor.arcServidorDM';
  IDARC = 'GUIDServidor = {6485B74B-AF50-4684-8112-6122A2555CD6}';

//  Atualiza��o
procedure Atualizar;
//  Convers�o

function RetornaNumeroDeString(sTexto: string): string;
//  Gera��o
//02/04/2015 - CARLOS.GASPAR - Salt: 172993/20/5

function GeraCNPJ: string;

function ZeroEsquerda(psString: string; pTamanho: integer): string;

function CalculaDVCNPJ(psCnpj: string): string;

function CalculaDVCPF(psCpf: string): string;

function GetNumeroCNPJ: string;

function RetornaCNPJValido: string;

procedure SetNumeroCNPJ(const Value: string);

function GetNumeroCPF: string;

function RetornaCPFValido: string;

function GeraCPF: string;

procedure SetNumeroCPF(const Value: string);
//--

//  Sele��o

procedure SelecionarAba(poPageControl: TPageControl; poAba: TTabSheet);

//  Data
function UltimoDiaUtilMes(pdData: TDateTime; pbSabDom: boolean): TDateTime;

function UltimoDiaDoMes(Data: TDateTime; lSabDom: boolean): TDateTime;

function PrimeiroDiadoMes(Data: TDateTime; lSabDom: boolean): TDateTime;

function RetornaDiaUtil(Data: TDateTime): string;

function FuncaoData(psData, psFormato: string): string;

function RetornaFinalDeSemana(Data: TDateTime): boolean;

// Limpeza
procedure LimparCacheParaTestes(sEntidade: string);

// Executar
function ExecutarProcesso(psArquivo: string): boolean;

function SomenteNumeros(sTexto: string): string;
//17/08/2015 - cesar.almeida - SALT: 186660/11/2

procedure TrocaSistema(psSistema: string);

//09/06/2015 - CARLOS.GASPAR - Salt: 186660/4/4
procedure AbrirTrocarSistema(psSistema: PChar);
//20/10/2015 - Shirleano.Junior - SALT: 186660/21/7

function CarregarDadosOpenOffice(psNomeArquivo: string): variant;

function CriaParametroOpenOffice(Nome: string; TipoData, pvPrograma: variant): variant;

function FileName2URL(FileName: string): string;

function FinalizarProcesso(ExeFileName: string): integer;
//Processo

function MatarProcesso(psArquivo: string): integer;

procedure Aguardar(pnTempo: integer);

procedure GravarVariavelExterna(psCampo: string; psValor: string);

procedure FinalizarVariavalExterna;

function LerVariavelExterna(psCampo: string): string;

function VerifiqueTextoDocumentoEditor(poTelaEditor: TffpgEditor; psTexto: string): boolean;

//Eventos Mouse
procedure PosicionarPonteiroMouse(Controle: TControl);

procedure CliqueDireitoMouse;

procedure CliqueEnter;

procedure CliqueSetaBaixo(iQtd: integer);

procedure CliqueEsquerdoMouse;

function RetornaLocalSistema(psLocal: string): string;

function AppPROEhLocal(psApp: string): boolean;

function IsStrANumber(const S: string): boolean;

procedure AdicionaValorArray(psValor: string);

function LocalizarEmArquivoImpresso(psValor: string): boolean;

function TelaExiste(psNomeTela: string): boolean;

// 26/10/2016  - Carlos.Gaspar - TASK: 66977
function GetAliasBase: string;

implementation

uses
  usegRepositorio, ComObj;

procedure SelecionarAba(poPageControl: TPageControl; poAba: TTabSheet);
begin
  if Assigned(poPageControl) then
    poPageControl.ActivePage := poAba
  else
    raise EMsgAvisoCliente.Create('PageControl n�o dispon�vel para selecionar a aba.');
end;

procedure Atualizar;
begin
  Application.ProcessMessages;
end;

function RetornaNumeroDeString(sTexto: string): string;
var
  i: integer;
  sNumero: string;
begin
  try
    for i := 0 to length(sTexto) do
    begin
      if sTexto[i] in ['0'..'9'] then
      begin
        sNumero := sNumero + (sTexto[i]);
      end;
    end;
    result := sNumero;
  except
    on EConvertError do
      raise EMsgAvisoCliente.Create('Erro ao pegar os n�meros da string');
  end;
end;

function UltimoDiaUtilMes(pdData: TDateTime; pbSabDom: boolean): TDateTime;
var
  Ano, Mes, Dia: word;
  AuxData: TDateTime;
  DiaDaSemana: integer;
begin
  AuxData := UltimoDiaUtilMes(pdData, False);
  if pbSabDom then
  begin
    DecodeDate(Auxdata, Ano, Mes, Dia);
    DiaDaSemana := DayOfWeek(AuxData);
    if DiaDaSemana = 1 then
      Dia := Dia - 2
    else if DiaDaSemana = 7 then
      Dec(Dia);
    AuxData := EnCodeDate(Ano, Mes, Dia);
  end;
  UltimoDiaUtilMes := AuxData;
end;

//21/10/2015 - ANTONIO.SOUSA - SALT: 186660/21/4
//Foram inseridos 1 par�metros: sEntidade - a pasta onde esta a entidade e a entidade que se quer apagar.
//Exemplo: LimparCacheParaTestes('Dados\Default\esajAgente*');
procedure LimparCacheParaTestes(sEntidade: string);
var
  cmd: string;
  sDiretorio: string;
begin
  sDiretorio := ExtractFilePath(Application.ExeName) + 'Cache';
  cmd := '/K del ' + sDiretorio + sEntidade;
  ShellExecute(handle, nil, 'cmd.exe', PChar(cmd), '', SW_HIDE);
  Sleep(2000);
end;

function UltimoDiaDoMes(Data: TDateTime; lSabDom: boolean): TDateTime;
var
  Ano, Mes, Dia: word;
  AuxData: TDateTime;
  DiaDaSemana: integer;
begin
  AuxData := PrimeiroDiadoMes((Data), False) - 1;
  if lSabDom then
  begin
    DecodeDate(Auxdata, Ano, Mes, Dia);
    DiaDaSemana := DayOfWeek(AuxData);
    if DiaDaSemana = 1 then
      Dia := Dia - 2
    else if DiaDaSemana = 7 then
      Dec(Dia);
    AuxData := EnCodeDate(Ano, Mes, Dia);
  end;
  UltimoDiaDoMes := AuxData;
end;

function PrimeiroDiadoMes(Data: TDateTime; lSabDom: boolean): TDateTime;
var
  Ano, Mes, Dia: word;
  DiaDaSemana: integer;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  Dia := 1;
  if lSabDom then
  begin
    DiaDaSemana := DayOfWeek(Data);
    if DiaDaSemana = 1 then
      Dia := 2
    else if DiaDaSemana = 7 then
      Dia := 3;
  end;
  PrimeiroDiadoMes := EncodeDate(Ano, Mes + 1, Dia);
end;

function ExecutarProcesso(psArquivo: string): boolean;
var
  oInicializacao: TStartUpInfo;
  oProcesso: TProcessInformation;
begin
  // Inicializa a estrutura TStartUpInfo indicando formato de abertura da janela
  // e setando os atributos obrigat�rios de serem inicializados.
  with oInicializacao do
  begin
    cb := 2048;
    lpReserved := nil;
    lpDesktop := nil;
    lpTitle := nil;
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_SHOWNORMAL; //SW_Hide; Se n�o quiser que apare�a na tela!
    cbReserved2 := 0;
    lpReserved2 := nil;
  end;

  // Cria o processo e passa por par�metro o arquivo a ser aberto.
  // Passa tamb�m as estruturas de controle, lStartUpInfo e lProcesso.

  if not CreateProcess(nil, PChar(psArquivo), nil, nil, False, 0, nil,
    PChar(ExtractFilePath(Application.ExeName)), oInicializacao, oProcesso) then
    result := False
  else
  begin
    //WaitForSingleObjetct faz com que o sistema aguarde o processo terminar
    //INFINITE � uma constante por�m pode ser passado o valor do tempo de espera
    WaitForSingleObject(oProcesso.hProcess, INFINITE);
    result := True;
  end;

end;

//02/04/2015 - CARLOS.GASPAR - Salt: 172993/20/5
function GeraCNPJ: string;
begin
  Randomize;
  result := SomenteNumeros(IntToStr(random(999999999999)));
end;

function ZeroEsquerda(psString: string; pTamanho: integer): string;
var
  i, len: integer;
begin
  len := length(psString);
  for i := len + 1 to pTamanho do
    psString := '0' + psString;
  result := psString;
end;

function CalculaDVCNPJ(psCnpj: string): string;
var
  digitos: array[1..14] of integer;
begin
  digitos[1] := StrToInt(psCnpj[1]);
  digitos[2] := StrToInt(psCnpj[2]);
  digitos[3] := StrToInt(psCnpj[3]);
  digitos[4] := StrToInt(psCnpj[4]);
  digitos[5] := StrToInt(psCnpj[5]);
  digitos[6] := StrToInt(psCnpj[6]);
  digitos[7] := StrToInt(psCnpj[7]);
  digitos[8] := StrToInt(psCnpj[8]);
  digitos[9] := StrToInt(psCnpj[9]);
  digitos[10] := StrToInt(psCnpj[10]);
  digitos[11] := StrToInt(psCnpj[11]);
  digitos[12] := StrToInt(psCnpj[12]);
  digitos[13] := 11 - (((digitos[1] * 5) + (digitos[2] * 4) + (digitos[3] * 3) +
    (digitos[4] * 2) + (digitos[5] * 9) + (digitos[6] * 8) + (digitos[7] * 7) +
    (digitos[8] * 6) + (digitos[9] * 5) + (digitos[10] * 4) + (digitos[11] * 3) +
    (digitos[12] * 2)) mod 11);
  if digitos[13] > 9 then
    digitos[13] := 0;

  digitos[14] := 11 - (((digitos[1] * 6) + (digitos[2] * 5) + (digitos[3] * 4) +
    (digitos[4] * 3) + (digitos[5] * 2) + (digitos[6] * 9) + (digitos[7] * 8) +
    (digitos[8] * 7) + (digitos[9] * 6) + (digitos[10] * 5) + (digitos[11] * 4) +
    (digitos[12] * 3) + (digitos[13] * 2)) mod 11);

  if digitos[14] > 9 then
    digitos[14] := 0;
  result := IntToStr(digitos[13]) + IntToStr(digitos[14]);
end;

function CalculaDVCPF(psCpf: string): string;
var
  digitos: array[1..11] of integer;
begin
  digitos[1] := StrToInt(psCpf[1]);
  digitos[2] := StrToInt(psCpf[2]);
  digitos[3] := StrToInt(psCpf[3]);
  digitos[4] := StrToInt(psCpf[4]);
  digitos[5] := StrToInt(psCpf[5]);
  digitos[6] := StrToInt(psCpf[6]);
  digitos[7] := StrToInt(psCpf[7]);
  digitos[8] := StrToInt(psCpf[8]);
  digitos[9] := StrToInt(psCpf[9]);

  digitos[10] := 11 - (((digitos[1] * 10) + (digitos[2] * 9) + (digitos[3] * 8) +
    (digitos[4] * 7) + (digitos[5] * 6) + (digitos[6] * 5) + (digitos[7] * 4) +
    (digitos[8] * 3) + (digitos[9] * 2)) mod 11);

  if digitos[10] > 9 then
    digitos[10] := 0;

  digitos[11] := 11 - (((digitos[1] * 11) + (digitos[2] * 10) + (digitos[3] * 9) +
    (digitos[4] * 8) + (digitos[5] * 7) + (digitos[6] * 6) + (digitos[7] * 5) +
    (digitos[8] * 4) + (digitos[9] * 3) + (digitos[10] * 2)) mod 11);

  if digitos[11] > 9 then
    digitos[11] := 0;

  result := IntToStr(digitos[10]) + IntToStr(digitos[11]);
end;

function GetNumeroCNPJ: string;
begin
  result := FsNumeroCNPJ;
end;

function RetornaCNPJValido: string;
begin
  SetNumeroCNPJ(SomenteNumeros(GeraCNPJ));
  result := GetNumeroCNPJ + CalculaDVCNPJ(GetNumeroCNPJ);
end;

procedure SetNumeroCNPJ(const Value: string);
begin
  FsNumeroCNPJ := ZeroEsquerda(Value, 12);
end;

function GetNumeroCPF: string;
begin
  result := FsNumeroCPF;
end;

function RetornaCPFValido: string;
begin
  SetNumeroCPF(SomenteNumeros(GeraCPF));
  result := GetNumeroCPF + CalculaDVCPF(GetNumeroCPF);
end;

function GeraCPF: string;
begin
  Randomize;
  result := SomenteNumeros(IntToStr(random(999999999)));
end;

procedure SetNumeroCPF(const Value: string);
begin
  FsNumeroCPF := ZeroEsquerda(Value, 9);
end;

function SomenteNumeros(sTexto: string): string;
var
  i: integer;
  sAux: string;
begin
  sAux := '';
  for i := 1 to length(sTexto) do
    if sTexto[i] in ['0'..'9'] then
      sAux := sAux + sTexto[i];
  result := sAux;
end;
//--

function RetornaFilaProcesso(psSituacaoProcesso: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoSql(psSituacaoProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('PROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//09/06/2015 - CARLOS.GASPAR - Salt: 186660/4/4
procedure AbrirTrocarSistema(psSistema: PChar);
begin
  ShellExecute(handle, 'open', PChar('TrocaSistema.exe'), psSistema, '', SW_HIDE);
end;

// Processos
function MatarProcesso(psArquivo: string): integer;
  //const  PROCESS_TERMINATE = $0001;
var
  FSnapshotHandle: THandle;
begin
  result := 0;
  FSnapshotHandle := FindWindow(PChar(psArquivo), nil);
  sendmessage(FSnapshotHandle, WM_CLOSE, 0, 0);
  Application.ProcessMessages;
  Sleep(1000);
end;

procedure Aguardar(pnTempo: integer);
begin
  Sleep(pnTempo);
end;

// Cria��o
procedure GravarVariavelExterna(psCampo: string; psValor: string);
var
  sArquivo: TStringList;
  nIndexResultado: integer;
begin
  try
    sArquivo := TStringList.Create;
    try
      FsLocalArquivo := CS_PATH_LOCAL + CS_NOME_ARQUIVO;
      //Arquivo quando nao existe esta gerando erro - verificar local onde esta apagando o arquivo
      if not FileExists(FsLocalArquivo) then
        sArquivo.SaveToFile(FsLocalArquivo);
      if FileExists(FsLocalArquivo) then
      begin
        sArquivo.LoadFromFile(FsLocalArquivo);

        nIndexResultado := sArquivo.IndexOf(psCampo);
        if nIndexResultado = -1 then
        begin
          sArquivo.Add(psCampo);
          sArquivo.add(psValor);
        end
        else
        begin
          sArquivo[(nIndexResultado + 1)] := psValor;
        end;

        sArquivo.SaveToFile(FsLocalArquivo);
      end
      else
        raise EMsgAvisoCliente.Create('Erro ao abrir o arquivo');
    finally
      FreeAndNil(sArquivo);
    end;
  except
    raise EMsgAvisoCliente.Create('Erro ao criar vari�vel externa');
  end;
end;

function LerVariavelExterna(psCampo: string): string;
var
  sArquivo: TStringList;
  nIndexResultado: integer;
  psLocalArquivo: string;
begin
  try
    sArquivo := TStringList.Create; //PC_OK
    psLocalArquivo := CS_PATH_LOCAL + CS_NOME_ARQUIVO;
    try
      if not FileExists(psLocalArquivo) then
        raise EMsgAvisoCliente.Create('Erro ao abrir o arquivo');

      sArquivo.LoadFromFile(psLocalArquivo);
      nIndexResultado := sArquivo.IndexOf(psCampo);
      if nIndexResultado = -1 then
        result := 'Inexistente'
      else
        result := sArquivo[(nIndexResultado + 1)];

    finally
      FreeAndNil(sArquivo); //PC_OK
    end;
  except
    raise EMsgAvisoCliente.Create('Erro ao abrir vari�vel externa');
  end;
end;

procedure FinalizarVariavalExterna;
begin
  FsLocalArquivo := CS_PATH_LOCAL + CS_NOME_ARQUIVO;
  try
    if FileExists(FsLocalArquivo) then
      DeleteFile(FsLocalArquivo);
  except
    raise EMsgAvisoCliente.Create('Erro ao deletar o arquivo da vari�vel externa');
  end;

end;

//07/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/11/3
function VerifiqueTextoDocumentoEditor(poTelaEditor: TffpgEditor; psTexto: string): boolean;
var
  i: integer;
  sTexto1: string;
  sTexto2: string;
begin
  result := False;
  i := pos(psTexto, poTelaEditor.oWPRichText.Text);
  poTelaEditor.oWPRichText.SelStart := i;
  poTelaEditor.oWPRichText.SelLength := length(psTexto);
  Application.ProcessMessages;

  if poTelaEditor.oWPRichText.SelText = psTexto then
  begin
    result := True;
  end
  else
  begin
    sTexto1 := copy(poTelaEditor.oWPRichText.SelText, 3, length(psTexto));
    sTexto2 := psTexto;
    if sTexto1 = sTexto2 then
    begin
      result := True;
    end
    else
    begin
      sTexto1 := copy(poTelaEditor.oWPRichText.SelText, 2, length(psTexto));
      sTexto2 := psTexto;
      if sTexto1 = sTexto2 then
      begin
        result := True;
      end;
    end;
  end;

end;

procedure TrocaSistema(psSistema: string);
var
  spcfg: TStringList;
begin
  try
    spcfg := TStringList.Create;

    try
      spcfg.LoadFromFile(ExtractFilePath(Application.ExeName) + 'spcfg.ini');
    except
      ShowMessage('Problema em abrir o arquivo');
    end;

    if psSistema = 'PG' then
    begin
      if spcfg.IndexOf('[Servidor]') <> -1 then
      begin
        spcfg[spcfg.IndexOf('[Servidor]') + 1] := nomePG;
        spcfg[spcfg.IndexOf('[Servidor]') + 2] := IDPG;
      end;
    end
    else
    if psSistema = 'PRO' then
    begin
      if spcfg.IndexOf('[Servidor]') <> -1 then
      begin
        spcfg[spcfg.IndexOf('[Servidor]') + 1] := nomePRO;
        spcfg[spcfg.IndexOf('[Servidor]') + 2] := IDPRO;
      end;
    end
    else
    if psSistema = 'ARC' then
    begin
      if spcfg.IndexOf('[Servidor]') <> -1 then
      begin
        spcfg[spcfg.IndexOf('[Servidor]') + 1] := nomeARC;
        spcfg[spcfg.IndexOf('[Servidor]') + 2] := IDARC;
      end;
    end;

    try
      spcfg.SaveToFile(ExtractFilePath(Application.ExeName) + 'spcfg.ini');
    except
      ShowMessage('Problema em fechar o arquivo');
    end;

  finally
    FreeAndNil(spcfg);
  end;

end;

//31/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/13/3
function RetornaDiaUtil(Data: TDateTime): string;
var
  tdDataAtual: TDateTime;
  iDiaSemana: integer;
begin
  tdDataAtual := (Data);
  iDiaSemana := DayOfWeek(tdDataAtual);

  if (iDiaSemana = 1) or (iDiaSemana = 7) then
  begin
    iDiaSemana := 2;
    tdDataAtual := tdDataAtual + iDiaSemana;
  end;
  result := datetostr(tdDataAtual);
end;

//14/09/2015 - leandro.humbert - SALT: 186660/15/7
function FuncaoData(psData, psFormato: string): string;
var
  sFormato: string;
begin
  sFormato := CS_MASCARA_DATA_CURTA;
  if psFormato <> '' then
    sFormato := psFormato;
  result := psData;
  if result = 'HOJE()' then
    result := FormatDateTime(sFormato, Now);
end;

//31/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/13/3
procedure PosicionarPonteiroMouse(Controle: TControl);
var
  IrPara: TPoint;
begin
  IrPara.X := Controle.Left + (Controle.Width div 2);
  IrPara.Y := Controle.Top + (Controle.Height div 2);
  if Controle.Parent <> nil then
    IrPara := Controle.Parent.ClientToScreen(IrPara);
  SetCursorPos(IrPara.X, IrPara.Y);
end;

//31/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/13/3
procedure CliqueDireitoMouse;
begin
  mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
  sleep(100);
  mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
end;

//31/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/13/3
procedure CliqueEnter;
begin
  keybd_event(VK_RETURN, 0, 0, 0);
end;

//31/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/13/3
procedure CliqueSetaBaixo(iQtd: integer);
var
  i: integer;
begin

  for i := 0 to iQtd do
  begin
    keybd_event(VK_DOWN, i, 0, 0);
  end;
end;

//31/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/13/3
procedure CliqueEsquerdoMouse;
begin
  mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
  sleep(100);
  mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
end;

// 16/09/2015  - Carlos.Gaspar - SALT: 186660/15/10
//Passar como par�metro: PSS5 ou PRO
function RetornaLocalSistema(psLocal: string): string;
var
  Lista: TStringList;
  IniFile: TIniFile;
  sLocal, sArq: string;
  sConfiguracao: string;
  sLocalAppPro: string;
  sLocalAppPss5: string;
begin
  if psLocal <> '' then
  begin
    Lista := TStringList.Create; //PC_OK
    try
      sLocal := ExtractFilePath(Application.ExeName);
      sArq := sLocal + CS_ARQUIVO_CONFIGURACAO_LOCAL_APP;
      IniFile := TIniFile.Create(sArq); //PC_OK
      if FileExists(sArq) then
      begin
        try
          sConfiguracao := CS_CONFIGURACAO;
          IniFile.ReadSectionValues(sConfiguracao, Lista);
          sLocalAppPss5 := Lista.Values[CS_PSS5];
          sLocalAppPro := Lista.Values[CS_PRO];
        except
          raise EMsgAvisoCliente.Create('Erro ao configurar caminho do execut�vel');
        end;
      end
      else
      begin
        ShowMessage('Arquivo de configura��o n�o encontrado!');
        Application.Terminate;
      end;
    finally
      if UpperCase(psLocal) = 'PSS5' then
        result := sLocalAppPss5
      else
        result := sLocalAppPro;
      FreeAndNil(Lista); //PC_OK
      FreeAndNil(IniFile); //PC_OK
    end;
  end;
end;

function AppPROEhLocal(psApp: string): boolean;
begin
  result := RetornaLocalSistema(psApp) = '';
end;

function IsStrANumber(const S: string): boolean;
begin
  result := True;
  try
    StrToInt(S);
  except
    result := False;
  end;
end;

// 22/10/2015 - Felipe.s SALT:186660/20/8
procedure AdicionaValorArray(psValor: string);
var
  n: integer;
begin
  n := High(gsNuProcessosArray) + 2;
  SetLength(gsNuProcessosArray, n);
  n := High(gsNuProcessosArray);
  gsNuProcessosArray[n] := psValor;
end;

function CarregarDadosOpenOffice(psNomeArquivo: string): variant;
begin
  Programa := CreateOleObject('com.sun.star.ServiceManager');
  Desktop := Programa.CreateInstance('com.sun.star.frame.Desktop');
  oParams := VarArrayCreate([0, 0], varVariant);
  oParams[0] := CriaParametroOpenOffice('Hidden', True, Programa);
  Document := Desktop.LoadComponentFromURL(FileName2URL(psNomeArquivo), '_blank', 0, oParams);
  result := Document;
end;

function CriaParametroOpenOffice(Nome: string; TipoData: variant; pvPrograma: variant): variant;
var
  Reflection: variant;
begin
  Reflection := pvPrograma.CreateInstance('com.sun.star.reflection.CoreReflection');
  Reflection.ForName('com.sun.star.beans.PropertyValue').CreateObject(result);
  result.Name := Nome;
  result.Value := TipoData;
end;

function FileName2URL(FileName: string): string;
begin
  result := '';
  if LowerCase(copy(FileName, 1, 8)) <> 'file:///' then
    result := 'file:///';
  result := result + StringReplace(FileName, '\', '/', [rfReplaceAll, rfIgnoreCase]);
end;

function FinalizarProcesso(ExeFileName: string): integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or
      (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))) then
      result := integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),
        FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function LocalizarEmArquivoImpresso(psValor: string): boolean;
var
  sArq: TStrings;
begin
  sArq := TStringList.Create;
  try
    Sleep(3000); //Necess�rio um tempo at� arquivo ser impresso
    sArq.LoadFromFile(CS_NOME_ARQUIVO_IMPTXT);
    sArq.Text := StringReplace(sArq.Text, ' ', '', [rfReplaceAll]);
    sArq.Text := StringReplace(sArq.Text, chr(13) + chr(10), '', [rfReplaceAll]);
    result := Pos(psValor, sArq.Text) > 0;
  finally
    sArq.Free;
    DeleteFile(CS_NOME_ARQUIVO_IMPTXT);
  end;
end;

function TelaExiste(psNomeTela: string): boolean;
begin
  result := TspForm(FindGlobalComponent(psNomeTela)) <> nil;
end;

function RetornaFinalDeSemana(Data: TDateTime): boolean;
var
  tdDataAtual: TDateTime;
  iDiaSemana: integer;
begin
  tdDataAtual := (Data);
  iDiaSemana := DayOfWeek(tdDataAtual);

  if (iDiaSemana = 1) or (iDiaSemana = 7) then
    result := True
  else
    result := False;
end;

// 26/10/2016  - Carlos.Gaspar - TASK: 66977
function GetAliasBase: string;
var
  oIni: TIniFile;
begin
  try
    oIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'spCFG.INI');
  finally
    result := oIni.ReadString('Database', 'Alias', '');
    FreeAndNil(oIni);
  end;
end;


end.


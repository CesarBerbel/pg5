unit ufpgExecutarPeticaoWeb;

interface

uses
  IniFiles, Windows, Classes, SysUtils, usajConstante, ShellApi, uspSendKeys,
  uproConsPeticaoIntermEletronica, uproVisualizaDocPetInterm, usajAssistente,
  dxEdLib, Controls, ADODB, Forms, TestFramework, FutureWindows, ufpgConstanteGUITests,
  uspDUnitDAO, uspForm, uspInterface, ufpgGUITestCase, uspFuncoes, uspDataModelTests,
  DB, uspGUITestCase, Dialogs, ufpgFuncoesGUITestes;

type
  TfpgExecutarPeticaoWeb = class(TfpgGUITestCase)
  private
    procedure LimparDiretorioPG5;
  public
    procedure CadastrarPeticaoInicialWeb(psJTR, psForo, psUsuario, psConpetencia,
      psClasseExt, psAssuntoExt, psDuasPartes: string);
    procedure CadastrarPeticaoIntermediariaWeb(psNuProcesso, psUsuario, psClasseExt,
      psAssuntoExt, psQuantidade, psDuasPartes: string);
    function ExtrairProcessoArquivo(psArquivo: string): string;
    function RodarArquivoWeb(const sArquivoBat: string; bExtrairProcesso: boolean = True): string;
  end;

implementation

var
  oArquivo: TSearchRec;
  sCaminhoINI: string;
  sCaminhoPastaPeticao: string;

const
  CS_JTR = 'JTR';
  CS_FORO = 'Foro';
  CS_CDUSUARIO = 'cdUsuario';
  CS_COMPETENCIA = 'Competencia';
  CS_CLASSEEXT = 'ClasseExt';
  CS_ASSUNTOEXT = 'AssuntoExt';
  CS_DUASPARTES = 'DuasPartes';
  CS_NUPROCESSO = 'nuProcesso';
  CS_QUANTIDADE = 'Quantidade';
  CS_TIPO_DISTRIBUICAO_DIRECIONADA = 'Vinculada';
//01/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
{*
  Método configura o spcfg.ini da pasta "Peticao PG5" para cadastrar petição Inicial
*}
procedure TfpgExecutarPeticaoWeb.CadastrarPeticaoInicialWeb(psJTR, psForo,
  psUsuario, psConpetencia, psClasseExt, psAssuntoExt, psDuasPartes: string);
var
  oConfigINI: TIniFile;
begin
  if sCaminhoINI = STRING_INDEFINIDO then
    sCaminhoINI := ExtractFilePath(Application.ExeName) + CS_CAMINHO_PETICAO + 'spcfg.ini';
  oConfigINI := TIniFile.Create(sCaminhoINI);
  try
    try
      SetFileAttributes(PChar(sCaminhoINI), FILE_ATTRIBUTE_NORMAL);
    except
      Check(False, 'Problemas ao ler o arquico "spcfg.ini" da pasta "Peticao PG5".');
    end;
    oConfigINI.WriteString('Comum', CS_JTR, psJTR);
    oConfigINI.WriteString('Comum', CS_FORO, psForo);
    oConfigINI.WriteString('Criar Inicial', CS_CDUSUARIO, psUsuario);
    oConfigINI.WriteString('Criar Inicial', CS_COMPETENCIA, psConpetencia);
    oConfigINI.WriteString('Criar Inicial', CS_CLASSEEXT, psClasseExt);
    oConfigINI.WriteString('Criar Inicial', CS_ASSUNTOEXT, psAssuntoExt);
    oConfigINI.WriteString('Criar Inicial', CS_DUASPARTES, psDuasPartes);
  finally
    FreeAndNil(oConfigINI);
  end;
end;

//01/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
{*
  Método configura o spcfg.ini da pasta "Peticao PG5" para cadastrar petição Intermediaria
*}
procedure TfpgExecutarPeticaoWeb.CadastrarPeticaoIntermediariaWeb(psNuProcesso,
  psUsuario, psClasseExt, psAssuntoExt, psQuantidade: string; psDuasPartes: string);
var
  oConfigINI: TIniFile;
begin
  if sCaminhoINI = STRING_INDEFINIDO then
    sCaminhoINI := ExtractFilePath(Application.ExeName) + CS_CAMINHO_PETICAO + 'spcfg.ini';
  oConfigINI := TIniFile.Create(sCaminhoINI);
  try
    try
      SetFileAttributes(PChar(sCaminhoINI), FILE_ATTRIBUTE_NORMAL);
    except
      Check(False, 'Problemas ao ler o arquico "spcfg.ini" da pasta "Peticao PG5".');
    end;

    oConfigINI.WriteString('Criar Intermediaria', CS_NUPROCESSO, psNuProcesso);
    oConfigINI.WriteString('Criar Intermediaria', CS_CDUSUARIO, psUsuario);
    oConfigINI.WriteString('Criar Intermediaria', CS_CLASSEEXT, psClasseExt);
    oConfigINI.WriteString('Criar Intermediaria', CS_ASSUNTOEXT, psAssuntoExt);
    oConfigINI.WriteString('Criar Intermediaria', CS_QUANTIDADE, psQuantidade);
    oConfigINI.WriteString('Criar Intermediaria', CS_DUASPARTES, psDuasPartes);
  finally
    FreeAndNil(oConfigINI);
  end;
end;

function TfpgExecutarPeticaoWeb.RodarArquivoWeb(const sArquivoBat: string;
  bExtrairProcesso: boolean = True): string;
var
  ohandle: THandle;
  oArquivo: TSearchRec;
  nContador: integer;
begin
  LimparDiretorioPG5;
  ohandle := 0;
  nContador := 0;
  result := '';
  try
    if sCaminhoPastaPeticao = STRING_INDEFINIDO then
      sCaminhoPastaPeticao := ExtractFilePath(Application.ExeName) + CS_CAMINHO_PETICAO;
    ShellExecute(ohandle, CS_MODO_ABRIR_ARQUIVO, PChar(sArquivoBat), STRING_INDEFINIDO,
      PChar(sCaminhoPastaPeticao), SW_SHOWNORMAL);
    //ExecutarEAguardar(sCaminhoPastaPeticao + sArquivoBat, True);
    //08/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
    {
    Aguarda o arquivo "GerarPeticoesIniciaisInt_NETTINT_DATA_NUMERO ARQUIVO__1.txt"
      ser criado na pasta "Peticao PG5"
      }
    repeat
      if FindFirst(sCaminhoPastaPeticao + CS_EXTENSAO_PETICAO, faAnyFile, oArquivo) <> 0 then
        sleep(1000);
      Inc(nContador);
      Check(nContador < 60,
        'Falha - Arquivo de petição inicial/intermediaria não foi criado na pasta Petição PG5!');
    until oArquivo.Name <> STRING_INDEFINIDO;
    //------
    //nContador := FindFirst(sCaminhoPastaPeticao + CS_EXTENSAO_PETICAO, faAnyFile, oArquivo);
    //Check(nContador <> 0,
    //  'Falha - Arquivo de petição inicial/intermediaria não foi criado na pasta Petição PG5!');
    if bExtrairProcesso then
      result := ExtrairProcessoArquivo(sCaminhoPastaPeticao + oArquivo.Name);
  finally
    MatarProcesso(CS_NOME_PROCESSO_PETICAO);
  end;
end;

function TfpgExecutarPeticaoWeb.ExtrairProcessoArquivo(psArquivo: string): string;
var
  oArquivoAberto: TStringList;
  sLinha: string;
begin
  //if FindFirst(sCaminhoPastaPeticao + CS_EXTENSAO_PETICAO, faAnyFile, oArquivo) = 0 then
  if FileExists(psArquivo) then
  begin
    oArquivoAberto := TStringList.Create;
    oArquivoAberto.LoadFromFile(psArquivo);
    // oArquivoAberto[10] - Pega a linha contendo o numero do Protocolo.
    try
      sLinha := oArquivoAberto[10];
      result := somenteNumeros(copy(sLinha, pos('(', sLinha), pos(')', sLinha)));
    finally
      FreeAndNil(oArquivoAberto);
      DeleteFile(psArquivo);
    end;
  end;
end;

procedure TfpgExecutarPeticaoWeb.LimparDiretorioPG5;
var
  sCaminhoINI: string;
  I: integer;
begin
  if sCaminhoINI = STRING_INDEFINIDO then
    sCaminhoINI := ExtractFilePath(Application.ExeName) + CS_CAMINHO_PETICAO + CS_EXTENSAO_PETICAO;
  I := FindFirst(sCaminhoINI, faAnyFile, oArquivo);
  while I = 0 do
  begin
    if (oArquivo.Attr and faDirectory) <> faDirectory then
    begin
      sCaminhoINI := ExtractFilePath(Application.ExeName) + CS_CAMINHO_PETICAO + oArquivo.Name;
      if not DeleteFile(sCaminhoINI) then
        ShowMessage('Erro ao deletar  ' + sCaminhoINI);
    end;
    I := FindNext(oArquivo);
  end;
end;
                                               
end.                                           
                                               
                                               

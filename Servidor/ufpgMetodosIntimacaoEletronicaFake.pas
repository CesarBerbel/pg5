unit ufpgMetodosIntimacaoEletronicaFake;

interface

uses
  ufpgMetodosIntimacaoEletronica, TestFrameWork, Windows, Forms, FutureWindows,
  SysUtils, uspClientDataSet, DB, usajConstante, uspExcecao, usajMensagemObjeto,
  uspConjuntoDados, usajPendenciaPrazo, uspControleTestesUnitarios;

type
  TfpgMetodosIntimacaoEletronicaFake = class(TfpgMetodosIntimacaoEletronica)
  private
    FoTabelaVirtualMensagemObjeto: TspClientDataSet;
    FoTabelaVirtualRecado: TspClientDataSet;
    FoTabelaVirtualPendenciaPrazo: TspClientDataSet;
    FnQntdUsuarios: integer;

    /// <summary>
    ///  Gera estruta metadados para pendencia prazo
    /// </summary>
    /// <param name="poDataSet">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure CriarEstruturaPendenciaPrazo(poDataSet: TspClientDataSet);
  protected
    /// <summary>
    ///  Quebra de dependência do método TsajDBase(FospDono.FspDB).DataAtual
    /// </summary>
    /// <returns>
    ///  TDateTime
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    function PegarDataAtual: TDateTime; override;

    /// <summary>
    ///  Quebra de dependência do conjunto de dadoss
    /// </summary>
    /// <param name="psCdCaracteristica">
    /// </param>
    /// <returns>
    ///  integer
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    function PegarCdTipoLocalCaracteristicaInterno(const psCdCaracteristica: integer): integer;
      override;

    /// <summary>
    ///  Quebra de dependência ao pegar mensagem objeto em aberto com associação a uma pendência
    /// </summary>
    /// <param name="psCdObjeto">
    /// </param>
    /// <param name="pnNuSeqPendencia">
    /// </param>
    /// <param name="psCdProcesso">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    function PegarObjetoEmAbertoDerivadoPendenciaInterno(const psCdObjeto: string;
      var pnNuSeqPendencia: integer; var psCdProcesso: string): boolean; override;

    /// <summary>
    ///  Quebra de dependência ao incluir pendência prazo
    /// </summary>
    /// <param name="psCdProcesso">
    /// </param>
    /// <param name="pnNuSeqPendencia">
    /// </param>
    /// <param name="pnCdOrigem">
    /// </param>
    /// <param name="psTexto">
    /// </param>
    /// <param name="pnCdMsgErro">
    /// </param>
    /// <param name="psDeComplErro">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    function IncluirPendenciaPrazoInterno(psCdProcesso: string;
      var pnNuSeqPendencia: integer; pnCdOrigem: integer; psTexto: string;
      var pnCdMsgErro: integer; var psDeComplErro: WideString): boolean; override;

    /// <summary>
    ///  Retorno de spDB nulo para utilização no teste
    /// </summary>
    /// <returns>
    ///  olevariant
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function PegarSpDB: olevariant; override;

    /// <summary>
    ///  Corresponde a ação salvar do sp4 para utilização no teste
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure SalvarConjuntoDadosNoBanco(poConjuntoDados: TspConjuntoDados); override;

    /// <summary>
    ///  Quebra de dependencia com a relação a geração de metadados
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <param name="psSpSelect">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure PegarMetaDados(poConjuntoDados: TspConjuntoDados; psSpSelect: string); override;

    /// <summary>
    ///  Quebra de dependencia do método GeraCodigo do sp4
    /// </summary>
    /// <param name="pesajMensagemObjeto">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure GerarCodigoMensagem(pesajMensagemObjeto: TesajMensagemObjeto); override;

    /// <summary>
    ///  Elimina dependencia com a data atual do servidor (TsajDBase(FospDono.FspDB).DataAtual)
    /// </summary>
    /// <returns>
    ///  TDateTime
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function PegarDataAtualComHora: TDateTime; override;

    /// <summary>
    ///  Verifica se mensagem em aberto no dataset virtual
    /// </summary>
    /// <param name="pesajMensagemObjeto">
    /// </param>
    /// <param name="psCdObjeto">
    /// </param>
    /// <param name="pnTipoMensagem">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function TestarSeExisteMensagemEmAberto(pesajMensagemObjeto: TesajMensagemObjeto;
      psCdObjeto: string; pnTipoMensagem: integer): boolean; override;

    /// <summary>
    ///  Encerramento de pendencia prazo
    /// </summary>
    /// <param name="pesajPendenciaPrazo">
    /// </param>
    /// <param name="pscdProcesso">
    /// </param>
    /// <param name="pnnuSeqPendencia">
    /// </param>
    /// <param name="pddtCumprimento">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function EncerrarPendenciaPrazo(pesajPendenciaPrazo: TesajPendenciaPrazo;
      pscdProcesso: string; pnnuSeqPendencia: integer;
      pddtCumprimento: TDateTime = NUMERO_INDEFINIDO): boolean; override;

    /// <summary>
    ///  Elimina a dependência ao pegar o usuário logado no servidor 
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function PegarUsuario: string; override;

  public
    constructor Create();
    destructor Destroy; override;

    /// <summary>
    ///  Retorna  uma lista de agentes
    /// </summary>
    /// <param name="pnCdForo">
    /// </param>
    /// <param name="pnCdTipoLocal">
    /// </param>
    /// <param name="pnCdLocal">
    /// </param>
    /// <param name="pnCdTipoAgente">
    /// </param>
    /// <returns>
    ///  olevariant
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    function PegarAgentesInterno(
      const pnCdForo, pnCdTipoLocal, pnCdLocal, pnCdTipoAgente: double): olevariant; override;

    /// <summary>
    ///  Método de auxilio para testar se a mensagem foi encerrada com sucesso
    /// </summary>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function TestarSeMensagemFoiEncerradaComSucesso: boolean;

    /// <summary>
    ///  Método de auxilio para testar se a mensagem foi incluida com sucesso
    /// </summary>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function TestarSeMensagemFoiIncluidaComSucesso: boolean;
  published

    /// <summary>
    ///  Quantidade de usuários necessário para o teste
    /// </summary>
    /// <value>
    ///  Integer
    /// </value>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    property fpgQntdUsuarios: integer read FnQntdUsuarios write FnQntdUsuarios;

    /// <summary>
    ///  Dataset virtual para armazenamento das mensagens objeto
    /// </summary>
    /// <value>
    ///  TspClientDataSet
    /// </value>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    property fpgTabelaVirtualMensagemObjeto: TspClientDataSet   
      read FoTabelaVirtualMensagemObjeto write FoTabelaVirtualMensagemObjeto;

    /// <summary>
    ///  Dataset virtual para armazenamento das pendencias prazo
    /// </summary>
    /// <value>
    ///  TspClientDataSet
    /// </value>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    property fpgTabelaVirtualPendenciaPrazo: TspClientDataSet   
      read FoTabelaVirtualPendenciaPrazo write FoTabelaVirtualPendenciaPrazo;
    /// <summary>
    ///  Dataset virtual para armazenamento dos recados
    /// </summary>
    /// <value>
    ///  TspClientDataSet
    /// </value>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    property fpgTabelaVirtualRecado: TspClientDataSet 
      read FoTabelaVirtualRecado   write FoTabelaVirtualRecado;
  end;

implementation

uses
  usajRecado, ufpgMetodosIntimacaoEletronicaTests;

{ TfpgMetodosIntimacaoEletronicaFake }

// 13/05/2013 - cleber.gomes - SALT: 103463/1
constructor TfpgMetodosIntimacaoEletronicaFake.Create;
begin
  FoTabelaVirtualMensagemObjeto := TspClientDataSet.Create(nil);  //PC_OK
  FoTabelaVirtualRecado := TspClientDataSet.Create(nil);  //PC_OK
  FoTabelaVirtualPendenciaPrazo := TspClientDataSet.Create(nil);  //PC_OK
  CriarEstruturaPendenciaPrazo(FoTabelaVirtualPendenciaPrazo);
  FnQntdUsuarios := 1;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
destructor TfpgMetodosIntimacaoEletronicaFake.Destroy;
begin
  FreeAndNil(FoTabelaVirtualMensagemObjeto);  //PC_OK
  FreeAndNil(FoTabelaVirtualRecado);  //PC_OK
  FreeAndNil(FoTabelaVirtualPendenciaPrazo); //PC_OK
  inherited;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaFake.CriarEstruturaPendenciaPrazo(
  poDataSet: TspClientDataSet);
begin
  poDataSet.FieldDefs.Add('CDPROCESSO', ftString, 13);
  poDataSet.FieldDefs.Add('NUSEQPENDENCIA', ftInteger);
  poDataSet.FieldDefs.Add('CDUSUARIOCADASTRO', ftString, 15);
  poDataSet.FieldDefs.Add('CDUSUARIOCUMP', ftString, 15);
  poDataSet.FieldDefs.Add('DEPENDENCIA', ftString, 2000);
  poDataSet.FieldDefs.Add('DTCADASTRO', ftDateTime);
  poDataSet.FieldDefs.Add('CDPESSOA', ftString, 10);
  poDataSet.FieldDefs.Add('CDORIGEM', ftInteger);
  poDataSet.FieldDefs.Add('NUDIASPRAZO', ftInteger);
  poDataSet.FieldDefs.Add('DTINICIOPRAZO', ftDateTime);
  poDataSet.FieldDefs.Add('DTVENCTOPRAZO', ftDateTime);
  poDataSet.FieldDefs.Add('DTCUMPRIMENTO', ftDateTime);
  poDataSet.FieldDefs.Add('DTPUBLICCIRCUL', ftDateTime);
  poDataSet.FieldDefs.Add('DEOBSERVACOES', ftString, 500);
  poDataSet.FieldDefs.Add('FLRECALCULAPRAZO', ftString, 1);
  poDataSet.CreateDataSet;
  poDataSet.Open;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.EncerrarPendenciaPrazo(
  pesajPendenciaPrazo: TesajPendenciaPrazo; pscdProcesso: string; pnnuSeqPendencia: integer;
  pddtCumprimento: TDateTime): boolean;
begin
  result := FoTabelaVirtualPendenciaPrazo.Locate('CDPROCESSO;NUSEQPENDENCIA',
    VarArrayOf([pscdProcesso, pnnuSeqPendencia]), []);

  if not result then
    exit;

  pesajPendenciaPrazo.Data := FoTabelaVirtualPendenciaPrazo.Data;

  pesajPendenciaPrazo.Edit;
  pesajPendenciaPrazo.FieldByName('CDUSUARIOCUMP').AsString := 'SAJ';
  pesajPendenciaPrazo.FieldByName('DTCUMPRIMENTO').AsDateTime := pddtCumprimento;
  pesajPendenciaPrazo.Post;

  FoTabelaVirtualPendenciaPrazo.Data := pesajPendenciaPrazo.Data;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaFake.GerarCodigoMensagem(
  pesajMensagemObjeto: TesajMensagemObjeto);
begin
  pesajMensagemObjeto.FieldByName('NUSEQMENSAGEMOBJET').AsInteger := 1;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.IncluirPendenciaPrazoInterno(psCdProcesso: string;
  var pnNuSeqPendencia: integer; pnCdOrigem: integer; psTexto: string;
  var pnCdMsgErro: integer; var psDeComplErro: WideString): boolean;
begin
  pnNuSeqPendencia := (FoTabelaVirtualPendenciaPrazo.RecordCount + 1);

  FoTabelaVirtualPendenciaPrazo.Insert;
  FoTabelaVirtualPendenciaPrazo.FieldByName('CDPROCESSO').AsString := psCdProcesso;
  FoTabelaVirtualPendenciaPrazo.FieldByName('NUSEQPENDENCIA').AsInteger := pnNuSeqPendencia;
  FoTabelaVirtualPendenciaPrazo.FieldByName('CDORIGEM').AsInteger := pnCdOrigem;
  FoTabelaVirtualPendenciaPrazo.FieldByName('DTCADASTRO').AsDateTime := Date;
  FoTabelaVirtualPendenciaPrazo.FieldByName('FLRECALCULAPRAZO').AsString := 'N';
  FoTabelaVirtualPendenciaPrazo.Post;

  result := (psCdProcesso = sCDPROCESSO_TESTE_1);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.PegarAgentesInterno(
  const pnCdForo, pnCdTipoLocal, pnCdLocal, pnCdTipoAgente: double): olevariant;
var
  ocdsAgentes: TspClientDataSet;
  i: integer;

  procedure AdicionarAgente(const poDataSet: TDataSet; const psCdAgente: string);
  begin
    poDataSet.Append;
    poDataSet.FieldByName('CDUSUARIO').AsString := psCdAgente;
    poDataSet.Post;
  end;

begin
  ocdsAgentes := TspClientDataSet.Create(nil);
  try
    ocdsAgentes.FieldDefs.Add('CDUSUARIO', ftString, 15);
    ocdsAgentes.CreateDataSet;
    ocdsAgentes.Open;

    for i := 1 to FnQntdUsuarios do
      AdicionarAgente(ocdsAgentes, 'SAJAT' + IntToStr(i));

    result := ocdsAgentes.Data;
  finally
    FreeAndNil(ocdsAgentes);
  end;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.PegarCdTipoLocalCaracteristicaInterno(
  const psCdCaracteristica: integer): integer;
begin
  result := NUMERO_INDEFINIDO;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.PegarDataAtual: TDateTime;
begin
  result := Now;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.PegarDataAtualComHora: TDateTime;
begin
  result := Now;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaFake.PegarMetaDados(poConjuntoDados: TspConjuntoDados;
  psSpSelect: string);
begin

  if poConjuntoDados.ClassNameIs('TesajMensagemObjeto') then
  begin
    poConjuntoDados.FieldDefs.Add('CDOBJETO', ftString, 13);
    poConjuntoDados.FieldDefs.Add('NUSEQMENSAGEMOBJET', ftInteger);
    poConjuntoDados.FieldDefs.Add('CDTIPOMENSAGEM', ftInteger);
    poConjuntoDados.FieldDefs.Add('DEMENSAGEM', ftString, 2000);
    poConjuntoDados.FieldDefs.Add('CDUSUENCERRAMENTO', ftString, 15);
    poConjuntoDados.FieldDefs.Add('DTUSUENCERRAMENTO', ftDateTime);
    poConjuntoDados.FieldDefs.Add('CDUSUINCLUSAO', ftString, 15);
    poConjuntoDados.FieldDefs.Add('DTUSUINCLUSAO', ftDateTime);
    poConjuntoDados.FieldDefs.Add('CDPROCESSO', ftString, 13);
    poConjuntoDados.FieldDefs.Add('NUSEQPENDENCIA', ftInteger);
    poConjuntoDados.CreateDataSet;
    poConjuntoDados.Open;
  end
  else
  if poConjuntoDados.ClassNameIs('TesajRecado') then
  begin
    poConjuntoDados.FieldDefs.Add('CDUSUARIODESTINO', ftString, 15);
    poConjuntoDados.FieldDefs.Add('DTRECADO', ftDateTime);
    poConjuntoDados.FieldDefs.Add('CDUSUARIOORIGEM', ftString, 15);
    poConjuntoDados.FieldDefs.Add('FLLIDO', ftString, 1);
    poConjuntoDados.FieldDefs.Add('FLEXCLUIDO', ftString, 1);
    poConjuntoDados.FieldDefs.Add('DERECADO', ftString, 2000);
    poConjuntoDados.FieldDefs.Add('CDUSUINCLUSAO', ftString, 15);
    poConjuntoDados.FieldDefs.Add('DTUSUINCLUSAO', ftDateTime);
    poConjuntoDados.CreateDataSet;
    poConjuntoDados.Open;
  end;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.PegarObjetoEmAbertoDerivadoPendenciaInterno(
  const psCdObjeto: string; var pnNuSeqPendencia: integer; var psCdProcesso: string): boolean;
begin
  pnNuSeqPendencia := NUMERO_INDEFINIDO;
  psCdProcesso := STRING_INDEFINIDO;
  result := FoTabelaVirtualMensagemObjeto.Locate('CDOBJETO', psCdObjeto, []);

  if not result then
    exit;

  psCdProcesso := FoTabelaVirtualMensagemObjeto.FieldByName('CDPROCESSO').AsString;
  pnNuSeqPendencia := FoTabelaVirtualMensagemObjeto.FieldByName('NUSEQPENDENCIA').AsInteger;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.PegarSpDB: olevariant;
begin
  result := null;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaFake.SalvarConjuntoDadosNoBanco(
  poConjuntoDados: TspConjuntoDados);
begin
  if poConjuntoDados.ClassNameIs('TesajMensagemObjeto') then
  begin
    FoTabelaVirtualMensagemObjeto.Data := poConjuntoDados.Data;
  end
  else
  if poConjuntoDados.ClassNameIs('TesajRecado') then
  begin
    FoTabelaVirtualRecado.Data := poConjuntoDados.Data;
  end
  else
  if poConjuntoDados.ClassNameIs('TesajPendenciaPrazo') then
  begin
    FoTabelaVirtualPendenciaPrazo.Data := poConjuntoDados.Data;
  end;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.TestarSeExisteMensagemEmAberto(
  pesajMensagemObjeto: TesajMensagemObjeto; psCdObjeto: string; pnTipoMensagem: integer): boolean;
begin
  pesajMensagemObjeto.Data := FoTabelaVirtualMensagemObjeto.Data;
  pesajMensagemObjeto.Filter := 'CDOBJETO = ''' + psCdObjeto + ''' AND CDTIPOMENSAGEM = ' +
    IntToStr(pnTipoMensagem) + '  AND DTUSUENCERRAMENTO IS NULL ' +
    ' AND CDUSUENCERRAMENTO IS NULL';
  pesajMensagemObjeto.Filtered := True;
  result := not pesajMensagemObjeto.IsEmpty;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.TestarSeMensagemFoiEncerradaComSucesso: boolean;
begin
  result := not (FoTabelaVirtualMensagemObjeto.FieldByName('CDUSUENCERRAMENTO').IsNull and
    FoTabelaVirtualMensagemObjeto.FieldByName('DTUSUENCERRAMENTO').IsNull);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.TestarSeMensagemFoiIncluidaComSucesso: boolean;
begin
  result := not FoTabelaVirtualMensagemObjeto.IsEmpty;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaFake.PegarUsuario: string;
begin
  result := 'SAJ';
end;

end.


{*******************************************************}
{*
{* ufpgDistribuicaoServFake.pas
{* Delphi Implementation of the Class TlfpgDistribuicaoServFake
{* Generated by Enterprise Architect
{* Created on:      10-jun-2013 12:01:14
{* Original author: maxback
{*  
{*******************************************************}

unit ufpgDistribuicaoServFake;

interface

uses
  ufpgDistribuicaoServ, SysUtils, spServidor_TLB, uspEntidade, uspConjuntoDados,
  uspGeraCodigo, uspAtualizacao, uspServidorAplicacao, usajConstante, DBClient,
  DB, uspClientDataSet, ActiveX, usaj4Geral, uspTestCase, ufpgPesoVara,
  UfpgPesoGlobalVara, ufpgPesoVaga, ufpgVaraVaga, ufpgPesoCartorio, ufpgPesoGlobalCart,
  uspFuncoes, uspFuncoesDataSet;

type

  TlfpgDistribuicaoServFake = class(TlfpgDistribuicaoServ)
  private
    //24/06/2013 - maxback - SALT 61989/1 - Determina que processo deve ser considerado possuidor de
    //registros em efpgProcMvCompensa
    FsCdProcessoComRegProcMvCompensa: string;
    FoTabelaVirtualPesoVara: TspClientDataSet;
    FoTabelaVirtualPesoGlobalVara: TspClientDataSet;
    FoTabelaVirtualPesoCartorio: TspClientDataSet;
    FoTabelaVirtualPesoGlobalCartorio: TspClientDataSet;
    FoTabelaVirtualPesoGlobalVaga: TspClientDataSet;
    FoTabelaVirtualPesoVaga: TspClientDataSet;
    //21/06/2013 - maxback - SALT 61989/1 -
    FoTabelaVirtualForoTipoCart: TspClientDataSet;

    procedure CriarEstruturaTabelaVirtualPesoVara(poClientDataSet: TspClientDataSet);
    procedure CriarEstruturaTabelaVirtualPesoGlobalVara(poClientDataSet: TspClientDataSet);
    procedure CriarEstruturaTabelaVirtualPesoCartorio(poClientDataSet: TspClientDataSet);
    procedure CriarEstruturaTabelaVirtualPesoGlobalCartorio(poClientDataSet: TspClientDataSet);
    procedure CriarEstruturaTabelaVirtualPesoGlobalVaga(poClientDataSet: TspClientDataSet);
    procedure CriarEstruturaTabelaVirtualDadosPesoVaga(poClientDataSet: TspClientDataSet);

    /// <summary>
    ///  Cria a estrutura de dados da tabela virtual de esajForoTipoCart.
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// //21/06/2013 - maxback - SALT 61989/1 -
    /// Alterado para adicionar tabela virtual de  inicio de contabiliza��o de pesos (foroTipoCart).
    /// </remarks>
    procedure CriarEstruturaTabelaVirtualForoTipoCart(poClientDataSet: TspClientDataSet);

    /// <summary>
    ///  Cria as estruturas de dados de apoio � classe fake.
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// //24/06/2013 - maxback - SALT 61989/1 -
    /// Alterado para adicionar tabela virtual de  inicio de contabiliza��o de pesos (foroTipoCart).
    /// </remarks>
    procedure CriarEstruturaDados;

    function RetornarTabelaVirtualParaSalvar(poConjuntoDados: TspConjuntoDados): TspClientDataSet;
  protected
    /// <summary>
    /// Simula a consulta no banco de dados da data de inicio da contabiliza��o de pesos para o
    /// foro e compet�ncia passados por par�metro.
    /// </summary>
    /// <param name="pnCdForo"> (integer) C�digo do foro.
    /// </param>
    /// <param name="pnCdTipoCartorio"> (integer) C�digo da compet�ncia.
    /// </param>
    /// <Returns> Retorna a data pesquisada ou DATA_INVALIDA caso n�o definida.
    /// </Returns>
    /// <remarks>
    /// //21/06/2013 - maxback - SALT 61989/1 - Consulta uma tabela virtual;
    /// </remarks>
    function PegarDataInformatizacaoInterno(const pnCdForo, pnCdTipoCartorio: integer): TDatetime;
      override;

    /// <summary>
    ///  Inicia uma transa��o.
    /// </summary>
    /// <param name="psLocal">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  //12/06/2013 - maxback - SALT 61989/1 - Quebra de depend�ncia.
    /// </remarks>
    procedure IniciarTransacaoInterno(const psLocal: string); override;

    /// <summary>
    ///  Confirma uma transa��o.
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  //12/06/2013 - maxback - SALT 61989/1 - Quebra de depend�ncia.
    /// </remarks>
    procedure EfetuarCommitNaTransacaoInterno; override;

    /// <summary>
    ///  Confirma uma transa��o.
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  //12/06/2013 - maxback - SALT 61989/1 - Quebra de depend�ncia.
    /// </remarks>
    procedure EfetuarRollbackNaTransacaoInterno; override;

    /// <summary>
    ///  Simula a opera��o de salvamento dos dados alterados/inseridos/removidos na entidade.
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  //12/06/2013 - maxback - SALT 61989/1
    ///  Quebra de depend�ncia do m�todo salve do conjunto de dados.
    /// </remarks>
    procedure SalvarNoBancoDeDados(poConjuntoDados: TspConjuntoDados); override;

    /// <summary>
    /// Define os metadados para um conjunto de dados com o objetivo de preparar o mesmo para
    /// inserir dados.
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <param name="psSpSelect">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  //12/06/2013 - maxback - SALT 61989/1
    /// Quebra de depend�ncia do m�todo metadados do conjunto de dados.
    /// </remarks>
    procedure DefinirMetadados(poConjuntoDados: TspConjuntoDados; psSpSelect: string); override;


    /// <summary>
    ///  Retorna o objeto spDB a ser usado em fun��es e cria��o de conjuntos de dados no servidor.
    /// </summary>
    /// <returns>
    ///  olevariant
    /// </returns>
    /// <remarks>
    /// //12/06/2013 - maxback - SALT 61989/1
    /// Quebra de depend�ncia do objeto spDB.
    /// </remarks>
    function PegarSpDB: olevariant; override;

    /// <summary>
    ///  Realiza a consulta de dados de peso da vara e armazena em poConjuntoDados.
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <param name="pnCdForo"> C�digo do foro da chave da vara.
    /// </param>
    /// <param name="pnCdVara"> C�digo da vara da chave da vara.
    /// </param>
    /// <param name="pnCdGrupoPeso"> C�digo do grupo de pesos.
    /// </param>
    /// <param name="pnNuFaixaDistrib"> N�mero da faixa de distribui��o.
    /// </param>
    /// <param name="psFlReuPreso"> Flag que indica se � R�u preso ('S' ou 'N')
    /// </param>
    /// <remarks>
    /// 10/06/2013 - maxback - SALT 61989/1 - Extraido m�todo que consulta os
    /// dados da entidade efpgPesoVara para quebra de depend�ncias a fim de permitir
    /// testes unit�rios.
    /// </remarks>
    procedure ConsultarDadosPesoVaraInterno(poConjuntoDados: TspConjuntoDados;
      const pnCdForo: integer; const pnCdVara: integer; const pnCdGrupoPeso: integer;
      const pnNuFaixaDistrib: integer; const psFlReuPreso: WideString); override;

    /// <summary>
    /// Realiza a consulta de dados de peso global da vara e armazena em poConjuntoDados.
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <param name="pnCdForo"> C�digo do foro da chave da vara.
    /// </param>
    /// <param name="pnCdVara"> C�digo da vara da chave da vara.
    /// </param>
    /// <remarks>
    /// 10/06/2013 - maxback - SALT 61989/1 - Extraido m�todo que consulta os
    /// dados da entidade efpgPesoGlobalVara para quebra de depend�ncias a fim de
    /// permitir testes unit�rios.
    /// </remarks>
    procedure ConsultarDadosPesoGlobalVaraInterno(poConjuntoDados: TspConjuntoDados;
      const pnCdForo: integer; const pnCdVara: integer); override;


    /// <summary>
    ///  Realiza a consulta de dados de peso do cart�rio e armazena em poConjuntoDados.
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <param name="pnCdForo"> C�digo do foro da chave do cart�rio.
    /// </param>
    /// <param name="pnCdCartorio"> C�digo do cart�rio da chave do cart�rio.
    /// </param>
    /// <param name="pnCdGrupoPeso"> C�digo do grupo de pesos.
    /// </param>
    /// <param name="pnNuFaixaDistrib"> N�mero da faixa de distribui��o.
    /// </param>
    /// <param name="psFlReuPreso"> Flag que indica se � R�u preso ('S' ou 'N')
    /// </param>
    /// <remarks>
    /// 10/06/2013 - maxback - SALT 61989/1 - Extraido m�todo que consulta os
    /// dados da entidade efpgPesoCartorio para quebra de depend�ncias a fim de
    /// permitir testes unit�rios.
    /// </remarks>
    procedure ConsultarDadosPesoCartorioInterno(poConjuntoDados: TspConjuntoDados;
      const pnCdForo: integer; const pnCdCartorio: integer; const pnCdGrupoPeso: integer;
      const pnNuFaixaDistrib: integer; const psFlReuPreso: WideString); override;

    /// <summary>
    ///  Simula a consulta de dados de peso do cart�rio e armazena em poConjuntoDados.
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <param name="pnCdForo"> C�digo do foro da chave do cart�rio.
    /// </param>
    /// <param name="pnCdCartorio"> C�digo do cart�rio da chave do cart�rio.
    /// </param>
    /// <remarks>
    /// 10/06/2013 - maxback - SALT 61989/1 - Extraido m�todo que consulta os
    /// dados da entidade efpgPesoGlobalCart para quebra de depend�ncias a fim de
    /// permitir testes unit�rios.
    /// </remarks>
    procedure ConsultarDadosPesoGlobalCartorioInterno(poConjuntoDados: TspConjuntoDados;
      const pnCdForo: integer; const pnCdCartorio: integer); override;

    /// <summary>
    ///  Simula a consulta de dados de peso da vara e armazena em poConjuntoDados.
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <param name="pnCdForo"> C�digo do foro da chave da vaga.
    /// </param>
    /// <param name="pnCdVara"> C�digo da vara da chave da vaga.
    /// </param>
    /// <param name="pnCdVaga"> C�digo da vaga da chave da vaga.
    /// </param>
    /// <param name="pnCdGrupoPeso"> C�digo do grupo de pesos.
    /// </param>
    /// <param name="pnNuFaixaDistrib"> N�mero da faixa de distribui��o.
    /// </param>
    /// <param name="psFlReuPreso"> Flag que indica se � R�u preso ('S' ou 'N')
    /// </param>
    /// <remarks>
    /// 10/06/2013 - maxback - SALT 61989/1 - Extraido m�todo que consulta os
    /// dados da entidade efpgPesoVaga para quebra de depend�ncias a fim de permitir
    /// testes unit�rios.
    /// </remarks>
    procedure ConsultarDadosPesoVagaInterno(poConjuntoDados: TspConjuntoDados;
      const pnCdForo: integer; const pnCdVara: integer; const pnCdVaga: integer;
      const pnCdGrupoPeso: integer; const pnNuFaixaDistrib: integer;
      const psFlReuPreso: WideString); override;


    /// <summary>
    ///  Simula a consulta de dados de peso da vara e armazena em poConjuntoDados.
    /// </summary>
    /// <param name="poConjuntoDados">
    /// </param>
    /// <param name="pnCdForo"> C�digo do foro da chave da vaga.
    /// </param>
    /// <param name="pnCdVara"> C�digo da vara da chave da vaga.
    /// </param>
    /// <param name="pnCdVaga"> C�digo da vaga da chave da vaga.
    /// </param>
    /// <remarks>
    /// 10/06/2013 - maxback - SALT 61989/1 - Extraido m�todo que consulta os
    /// dados da entidade efpgVaraVaga para quebra de depend�ncias a fim de permitir
    /// testes unit�rios.
    /// </remarks>
    procedure ConsultarDadosPesoGlobalVagaInterno(poConjuntoDados: TspConjuntoDados;
      const pnCdForo: integer; const pnCdVara: integer; const pnCdVaga: integer); override;
    //Salva os dados alterados/inseridos/removidos na entidade.

    /// <summary>
    ///  Testa se o processo tem algum registro de compensa peso.
    /// </summary>
    /// <param name="psCdProcesso">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  //24/06/2013 - maxback - SALT 61989/1 - Compara o processo passado com
    ///  FsCdProcessoComRegProcMvCompensa (que � definido via propriedade
    ///  fpgCdProcessoComRegProcMvCompensa de acordo com o cen�rio de teste).
    /// </remarks>
    function TestarSeExisteRegistroCompensaPesoProcesso(const psCdProcesso: string): boolean;
      override;


  public
    constructor spCreate(AOwner: TspServidorAplicacao; const guid: TGUID;
      const DispIntf: TGUID); override;
    destructor Destroy; override;

    /// <summary>
    /// Propriedade que indica o c�digo de processo que deve ser considerado com
    /// registro em efpgProcMvCompensa (para efeitos de regra de neg�cio).
    /// </summary>
    /// <remarks>
    /// //24/06/2013 - maxback - SALT 61989/1 -
    /// </remarks>
    property fpgCdProcessoComRegProcMvCompensa: string   
      read FsCdProcessoComRegProcMvCompensa write FsCdProcessoComRegProcMvCompensa;

    /// <summary>
    /// Propriedade que aponta para o dataset que simula a tabela efpgPesoVara.
    /// </summary>
    /// <remarks>
    /// SALT 61989/1 -
    /// </remarks>
    property fpgTabelaVirtualPesoVara: TspClientDataSet read FoTabelaVirtualPesoVara;

    /// <summary>
    /// Propriedade que aponta para o dataset que simula a tabela efpgPesoGlobalVara.
    /// </summary>
    /// <remarks>
    /// SALT 61989/1 -
    /// </remarks>
    property fpgTabelaVirtualPesoGlobalVara: TspClientDataSet read FoTabelaVirtualPesoGlobalVara;

    /// <summary>
    /// Propriedade que aponta para o dataset que simula a tabela efpgPesoCartorio.
    /// </summary>
    /// <remarks>
    /// SALT 61989/1 -
    /// </remarks>
    property fpgTabelaVirtualPesoCartorio: TspClientDataSet read FoTabelaVirtualPesoCartorio;

    /// <summary>
    /// Propriedade que aponta para o dataset que simula a tabela efpgPesoGlobalCartorio.
    /// </summary>
    /// <remarks>
    /// SALT 61989/1 -
    /// </remarks>
    property fpgTabelaVirtualPesoGlobalCartorio: TspClientDataSet   
      read FoTabelaVirtualPesoGlobalCartorio;

    /// <summary>
    /// Propriedade que aponta para o dataset que simula a tabela efpgPesoVaraVaga.
    /// </summary>
    /// <remarks>
    /// SALT 61989/1 -
    /// </remarks>
    property fpgTabelaVirtualPesoGlobalVaga: TspClientDataSet read FoTabelaVirtualPesoGlobalVaga;

    /// <summary>
    /// Propriedade que aponta para o dataset que simula a tabela efpgPesoVaga.
    /// </summary>
    /// <remarks>
    /// SALT 61989/1 -
    /// </remarks>
    property fpgTabelaVirtualPesoVaga: TspClientDataSet read FoTabelaVirtualPesoVaga;
    /// <summary>
    /// Propriedade que aponta para o dataset que simula a tabela esajForoTipoCart.
    /// </summary>
    /// <remarks>
    /// //24/06/2013 - maxback - SALT 61989/1 -
    /// </remarks>
    property fpgTabelaVirtualForoTipoCart: TspClientDataSet read FoTabelaVirtualForoTipoCart;
  end;

implementation

{implementation of TlfpgDistribuicaoServFake}


constructor TlfpgDistribuicaoServFake.spCreate(AOwner: TspServidorAplicacao;
  const guid, DispIntf: TGUID);
begin
  inherited spCreate(AOwner, guid, DispIntf);
  FsCdProcessoComRegProcMvCompensa := STRING_INDEFINIDO;
  CriarEstruturaDados;
end;

destructor TlfpgDistribuicaoServFake.Destroy;
begin
  //21/06/2013 - maxback - SALT 61989/1 -
  FreeAndNil(FoTabelaVirtualForoTipoCart); //PC_OK
  FreeAndNil(FoTabelaVirtualPesoVaga); //PC_OK
  FreeAndNil(FoTabelaVirtualPesoGlobalVaga); //PC_OK
  FreeAndNil(FoTabelaVirtualPesoGlobalCartorio); //PC_OK
  FreeAndNil(FoTabelaVirtualPesoCartorio); //PC_OK
  FreeAndNil(FoTabelaVirtualPesoGlobalVara); //PC_OK
  FreeAndNil(FoTabelaVirtualPesoVara); //PC_OK

  inherited;
end;


procedure TlfpgDistribuicaoServFake.ConsultarDadosPesoVaraInterno(
  poConjuntoDados: TspConjuntoDados;
  const pnCdForo: integer; const pnCdVara: integer; const pnCdGrupoPeso: integer;
  const pnNuFaixaDistrib: integer; const psFlReuPreso: WideString);
begin
  TspTestCase.CriarDadosConsulta(poConjuntoDados, FoTabelaVirtualPesoVara,
    Format('cdForo = %d and cdVara = %d and cdGrupoPeso = %d and nuFaixaDist = %d and ' +
    'flReuPreso = ''%s''', [pnCdForo, pnCdVara, pnCdGrupoPeso, pnNuFaixaDistrib, psFlReuPreso]));
end;

procedure TlfpgDistribuicaoServFake.ConsultarDadosPesoGlobalVaraInterno(
  poConjuntoDados: TspConjuntoDados; const pnCdForo: integer; const pnCdVara: integer);
begin
  TspTestCase.CriarDadosConsulta(poConjuntoDados, FoTabelaVirtualPesoGlobalVara,
    Format('cdForo = %d and cdVara = %d', [pnCdForo, pnCdVara]));
end;

procedure TlfpgDistribuicaoServFake.ConsultarDadosPesoCartorioInterno(
  poConjuntoDados: TspConjuntoDados; const pnCdForo: integer; const pnCdCartorio: integer;
  const pnCdGrupoPeso: integer; const pnNuFaixaDistrib: integer; const psFlReuPreso: WideString);
begin
  TspTestCase.CriarDadosConsulta(poConjuntoDados, FoTabelaVirtualPesoCartorio,
    Format('cdForo = %d and cdCartorio = %d and cdGrupoPeso = %d and nuFaixaDist = %d and ' +
    'flReuPreso = ''%s''', [pnCdForo, pnCdCartorio, pnCdGrupoPeso, pnNuFaixaDistrib,
    psFlReuPreso]));
end;

procedure TlfpgDistribuicaoServFake.ConsultarDadosPesoGlobalCartorioInterno(
  poConjuntoDados: TspConjuntoDados; const pnCdForo: integer; const pnCdCartorio: integer);
begin
  TspTestCase.CriarDadosConsulta(poConjuntoDados, FoTabelaVirtualPesoGlobalCartorio,
    Format('cdForo = %d and cdCartorio = %d', [pnCdForo, pnCdCartorio]));
end;

procedure TlfpgDistribuicaoServFake.ConsultarDadosPesoVagaInterno(
  poConjuntoDados: TspConjuntoDados;
  const pnCdForo: integer; const pnCdVara: integer; const pnCdVaga: integer;
  const pnCdGrupoPeso: integer; const pnNuFaixaDistrib: integer; const psFlReuPreso: WideString);
begin
  TspTestCase.CriarDadosConsulta(poConjuntoDados, FoTabelaVirtualPesoVaga,
    Format('cdForo = %d and cdVara = %d and cdVaga = %d and cdGrupoPeso = %d and ' +
    'nuFaixaDist = %d and flReuPreso = ''%s''', [pnCdForo, pnCdVara, pnCdVaga,
    pnCdGrupoPeso, pnNuFaixaDistrib, psFlReuPreso]));
end;

procedure TlfpgDistribuicaoServFake.ConsultarDadosPesoGlobalVagaInterno(
  poConjuntoDados: TspConjuntoDados; const pnCdForo: integer; const pnCdVara: integer;
  const pnCdVaga: integer);
begin
  TspTestCase.CriarDadosConsulta(poConjuntoDados, FoTabelaVirtualPesoGlobalVaga,
    Format('cdForo = %d and cdVara = %d and cdVaga = %d', [pnCdForo, pnCdVara, pnCdVaga]));
end;

procedure TlfpgDistribuicaoServFake.SalvarNoBancoDeDados(poConjuntoDados: TspConjuntoDados);
var
  oTabelaVirtual: TspClientDataSet;
begin
  oTabelaVirtual := RetornarTabelaVirtualParaSalvar(poConjuntoDados);
  TspTestCase.SalvarAlteracoesNaTabelaVirtual(oTabelaVirtual, poConjuntoDados,
    oTabelaVirtual.IndexFieldNames);
end;

procedure TlfpgDistribuicaoServFake.CriarEstruturaDados;
begin
  FoTabelaVirtualPesoVara := TspClientDataSet.Create(nil); //PC_OK
  FoTabelaVirtualPesoGlobalVara := TspClientDataSet.Create(nil); //PC_OK
  FoTabelaVirtualPesoCartorio := TspClientDataSet.Create(nil); //PC_OK
  FoTabelaVirtualPesoGlobalCartorio := TspClientDataSet.Create(nil); //PC_OK
  FoTabelaVirtualPesoGlobalVaga := TspClientDataSet.Create(nil); //PC_OK
  FoTabelaVirtualPesoVaga := TspClientDataSet.Create(nil); //PC_OK
  //21/06/2013 - maxback - SALT 61989/1 -
  FoTabelaVirtualForoTipoCart := TspClientDataSet.Create(nil); //PC_OK

  CriarEstruturaTabelaVirtualPesoVara(FoTabelaVirtualPesoVara);
  CriarEstruturaTabelaVirtualPesoGlobalVara(FoTabelaVirtualPesoGlobalVara);
  CriarEstruturaTabelaVirtualPesoCartorio(FoTabelaVirtualPesoCartorio);
  CriarEstruturaTabelaVirtualPesoGlobalCartorio(FoTabelaVirtualPesoGlobalCartorio);
  CriarEstruturaTabelaVirtualPesoGlobalVaga(FoTabelaVirtualPesoGlobalVaga);
  CriarEstruturaTabelaVirtualDadosPesoVaga(FoTabelaVirtualPesoVaga);
  //21/06/2013 - maxback - SALT 61989/1 -
  CriarEstruturaTabelaVirtualForoTipoCart(FoTabelaVirtualForoTipoCart);
end;

procedure TlfpgDistribuicaoServFake.CriarEstruturaTabelaVirtualDadosPesoVaga(
  poClientDataSet: TspClientDataSet);
begin
  poClientDataSet.FieldDefs.Add('CDFORO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDVARA', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDVAGA', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDGRUPOPESO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('NUFAIXADIST', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('FLREUPRESO', ftString, 1, True);
  poClientDataSet.FieldDefs.Add('QTFICTICIA', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTENTRADODISTRIB', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTENTRADOREDISTRIB', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTENTRADOALTER', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTEXCLUIDO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTCANCELADO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOALTER', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOREDISTRIB', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTTOTAL', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOMOVIMENT', ftFloat, 0, True);
  poClientDataSet.CreateDataSet;
  poClientDataSet.Active := True;

  poClientDataSet.IndexFieldNames := 'CDFORO;CDVARA;CDVAGA;CDGRUPOPESO;NUFAIXADIST;FLREUPRESO';

end;

procedure TlfpgDistribuicaoServFake.CriarEstruturaTabelaVirtualPesoCartorio(
  poClientDataSet: TspClientDataSet);
begin
  poClientDataSet.FieldDefs.Add('CDFORO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDCARTORIO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDGRUPOPESO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('NUFAIXADIST', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('FLREUPRESO', ftString, 1, True);
  poClientDataSet.FieldDefs.Add('QTINICIAL', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTDISTRIBSORTEIO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTDISTRIBDEPEND', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTDISTRIBPREV', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTREDISTRIBSORTEIO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTREDISTRIBDEPEND', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTREDISTRIBPREV', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTENTRADOALTER', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTEXCLUIDO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTCANCELADO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOALTER', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOREDISTRIB', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTTOTAL', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOMOVIMENT', ftFloat, 0, True);
  poClientDataSet.CreateDataSet;
  poClientDataSet.Active := True;

  poClientDataSet.IndexFieldNames := 'CDFORO;CDCARTORIO;CDGRUPOPESO;NUFAIXADIST;FLREUPRESO';
end;

procedure TlfpgDistribuicaoServFake.CriarEstruturaTabelaVirtualPesoGlobalCartorio(
  poClientDataSet: TspClientDataSet);
begin
  poClientDataSet.FieldDefs.Add('CDFORO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDCARTORIO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTPESOGLOBAL', ftFloat, 0, True);
  poClientDataSet.CreateDataSet;
  poClientDataSet.Active := True;

  poClientDataSet.IndexFieldNames := 'CDFORO;CDCARTORIO';

end;

procedure TlfpgDistribuicaoServFake.CriarEstruturaTabelaVirtualPesoGlobalVaga(
  poClientDataSet: TspClientDataSet);
begin
  poClientDataSet.FieldDefs.Add('CDFORO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDVARA', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDVAGA', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('FLVAGAATIVA', ftString, 1, True);
  poClientDataSet.FieldDefs.Add('QTPESOGLOBAL', ftFloat, 0);
  poClientDataSet.FieldDefs.Add('DEVAGA', ftString, 60);
  poClientDataSet.CreateDataSet;
  poClientDataSet.Active := True;

  poClientDataSet.IndexFieldNames := 'CDFORO;CDVARA;CDVAGA';
end;

procedure TlfpgDistribuicaoServFake.CriarEstruturaTabelaVirtualPesoGlobalVara(
  poClientDataSet: TspClientDataSet);
begin
  poClientDataSet.FieldDefs.Add('CDFORO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDVARA', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTPESOGLOBAL', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTPESOGLOBALPREV', ftFloat, 0);
  poClientDataSet.CreateDataSet;
  poClientDataSet.Active := True;

  poClientDataSet.IndexFieldNames := 'CDFORO;CDVARA';
end;

procedure TlfpgDistribuicaoServFake.CriarEstruturaTabelaVirtualPesoVara(
  poClientDataSet: TspClientDataSet);
begin
  poClientDataSet.FieldDefs.Add('CDFORO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDVARA', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDGRUPOPESO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('NUFAIXADIST', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('FLREUPRESO', ftString, 1, True);
  poClientDataSet.FieldDefs.Add('QTINICIAL', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTDISTRIBSORTEIO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTDISTRIBDEPEND', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTDISTRIBPREV', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTREDISTRIBSORTEIO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTREDISTRIBDEPEND', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTREDISTRIBPREV', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTENTRADOALTER', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTEXCLUIDO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTCANCELADO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOALTER', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOREDISTRIB', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTTOTAL', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTDISTRIBVARANOVA', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('QTSAIDOMOVIMENT', ftFloat, 0, True);
  poClientDataSet.CreateDataSet;
  poClientDataSet.Active := True;

  poClientDataSet.IndexFieldNames := 'CDFORO;CDVARA;CDGRUPOPESO;NUFAIXADIST;FLREUPRESO';
end;

function TlfpgDistribuicaoServFake.RetornarTabelaVirtualParaSalvar(
  poConjuntoDados: TspConjuntoDados): TspClientDataSet;
begin
  result := nil;
  if poConjuntoDados is TefpgPesoGlobalVara then
    result := FoTabelaVirtualPesoGlobalVara
  else if poConjuntoDados is TefpgPesoVara then
    result := FoTabelaVirtualPesoVara
  else if poConjuntoDados is TefpgPesoCartorio then
    result := FoTabelaVirtualPesoCartorio
  else if poConjuntoDados is TefpgPesoGlobalCart then
    result := FoTabelaVirtualPesoGlobalCartorio
  else if poConjuntoDados is TefpgVaraVaga then
    result := FoTabelaVirtualPesoGlobalVaga
  else if poConjuntoDados is TefpgPesoVaga then
    result := FoTabelaVirtualPesoVaga;
end;

procedure TlfpgDistribuicaoServFake.DefinirMetadados(poConjuntoDados: TspConjuntoDados;
  psSpSelect: string);
var
  oTabelaVirtual: TspClientDataSet;
begin
  //inherited;

  oTabelaVirtual := RetornarTabelaVirtualParaSalvar(poConjuntoDados);
  if not Assigned(oTabelaVirtual) then
    Exit;

  poConjuntoDados.Filtered := False;
  poConjuntoDados.Data := oTabelaVirtual.Data;
  while not poConjuntoDados.EOF do
    poConjuntoDados.Delete;

  poConjuntoDados.MergeChangeLog;
  poConjuntoDados.CancelUpdates;
end;

procedure TlfpgDistribuicaoServFake.EfetuarCommitNaTransacaoInterno;
begin
  //inherited;
  //ver com ofazer isso: eliminar a copai de segunranca => Nada a fazer por hora pois n�o pretendo testar isso
end;

procedure TlfpgDistribuicaoServFake.EfetuarRollbackNaTransacaoInterno;
begin
  //inherited;
  //ver com ofazer isso: restaurar da c�pia de seguran�a? => Nada a fazer por hora pois n�o pretendo testar isso
end;

procedure TlfpgDistribuicaoServFake.IniciarTransacaoInterno(const psLocal: string);
begin
  //inherited;
  //ver com ofazer isso: uma copia dos dados de backup para restaurar depois??? => Nada a fazer por hora pois n�o pretendo testar isso
end;

function TlfpgDistribuicaoServFake.PegarSpDB: olevariant;
begin
  result := null;
end;

//21/06/2013 - maxback - SALT 61989/1 -
function TlfpgDistribuicaoServFake.PegarDataInformatizacaoInterno(
  const pnCdForo, pnCdTipoCartorio: integer): TDatetime;
var
  oConjuntoDados: TspConjuntoDados;
begin
  result := DATA_INDEFINIDA;

  oConjuntoDados := TspConjuntoDados.Create(nil);
  try
    TspTestCase.CriarDadosConsulta(oConjuntoDados, FoTabelaVirtualForoTipoCart,
      Format('cdForo = %d and cdTipoCartorio = %d', [pnCdForo, pnCdTipoCartorio]));

    if (not oConjuntoDados.isEmpty) and
      (not oConjuntoDados.FieldByName('dtInicioPesoVara').isNull) then
      result := oConjuntoDados.FieldByName('dtInicioPesoVara').AsDateTime;
  finally
    FreeAndNil(oConjuntoDados);
  end;
end;

//21/06/2013 - maxback - SALT 61989/1 -
procedure TlfpgDistribuicaoServFake.CriarEstruturaTabelaVirtualForoTipoCart(
  poClientDataSet: TspClientDataSet);
begin
  //cdForo, cdTipoCartorio, dtInicioPesoVara
  poClientDataSet.FieldDefs.Add('CDFORO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('CDTIPOCARTORIO', ftFloat, 0, True);
  poClientDataSet.FieldDefs.Add('DTINICIOPESOVARA', ftDatetime);
  poClientDataSet.CreateDataSet;
  poClientDataSet.Active := True;

  poClientDataSet.IndexFieldNames := 'CDFORO;CDTIPOCARTORIO';

end;

//24/06/2013 - maxback - SALT 61989/1 -
function TlfpgDistribuicaoServFake.TestarSeExisteRegistroCompensaPesoProcesso(
  const psCdProcesso: string): boolean;
begin
  result := (psCdProcesso = FsCdProcessoComRegProcMvCompensa);
end;

end.


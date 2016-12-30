unit ufpgCtrlProcessoParteFake;

{*****************************************************************************
Projeto/Sistema: PG5 / Componentes
Objetivo: Implementar a classe fake para testes unit�rios da classe TfpgCtrlProcessoParte
Cria��o: 22/11/2014 - rodrigo.db1
*****************************************************************************}

interface

uses
  DB, SysUtils, uspClientDataSet, ufpgCtrlProcessoParte;

type
  TfpgCtrlProcessoParteFake = class(TfpgCtrlProcessoParte)
  private
    FocdsPermissoes: TspClientDataSet;
    FsIDTeste: string;
    /// <summary>
    ///  Carrega os dados de permiss�o para processos distribu�dos
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure CarregarDadosPermissaoProcessosDistribuidos;
    /// <summary>
    ///  Carrega os dados da planilha
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure CarregarDadosPlanilha;
    /// <summary>
    ///  Retorna a vari�vel FnIDTeste
    /// </summary>
    /// <returns>
    ///  integer
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    function GetfpgIDTeste: string;
    /// <summary>
    ///  Define valor para a vari�vel FnIDTeste
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure SetfpgIDTeste(const Value: string);
  protected
    /// <summary>
    ///  Sobrescreve o m�todo PegarAutorizacaoComponente para utilizar no teste unit�rio
    /// </summary>
    /// <param name="psnmComponente">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    function PegarAutorizacaoComponente(const psnmComponente: string): boolean; override;
  public
    /// <summary>
    ///  Cria os objetos necess�rios para o funcionamento da classe
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    constructor Create;
    /// <summary>
    ///  Destr�i os objetos utilizados pela classe
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    destructor Destroy; override;
    /// <summary>
    ///  Carrega os dados necess�rios para o teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    procedure CarregarDados;
  published
    /// <summary>
    ///  ID do teste
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    ///  Remarks
    ///  28/11/2014 - rodrigo.db1 - SALT: 152429/1
    /// </remarks>
    property fpgIDTeste: string read GetfpgIDTeste write SetfpgIDTeste;
  end;

implementation

uses
  ADODB, uspDUnitDAO, uspFuncoesExcel, usajConstante;

const
  sNOME_PLANILHA = 'fpgCtrlProcessoParteTests.xls';

{ TfpgCtrlProcessoParteFake }

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
constructor TfpgCtrlProcessoParteFake.Create;
begin
  inherited;
  FocdsPermissoes := TspClientDataSet.Create(nil); //PC_OK
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
destructor TfpgCtrlProcessoParteFake.Destroy;
begin
  inherited;
  if Assigned(FocdsPermissoes) then
  begin
    FreeAndNil(FocdsPermissoes); //PC_OK
  end;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteFake.CarregarDados;
begin
  CarregarDadosPermissaoProcessosDistribuidos;
  CarregarDadosPlanilha;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteFake.CarregarDadosPermissaoProcessosDistribuidos;
begin
  FbUtilizaPermissaoProcessosDistribuidos := PegarUtilizaPermissaoProcessosDistribuidos;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteFake.CarregarDadosPlanilha;
const
  sABA_PLANILHA = 'DadosAutorizacao';
var
  vDados: TADOQuery;
begin
  FbUtilizaPermissaoProcessosDistribuidos := PegarUtilizaPermissaoProcessosDistribuidos;

  FocdsPermissoes.FieldDefs.Clear;
  vDados := TADOQuery.Create(nil);
  try
    TspDUnitDAO.PegarInstancia.PegarDadosExcel(vDados, sNOME_PLANILHA, sABA_PLANILHA, FsIDTeste);
    ConverterAdoQueryParaDataSet(vDados, FocdsPermissoes);
  finally
    FreeAndNil(vDados);
  end;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
function TfpgCtrlProcessoParteFake.GetfpgIDTeste: string;
begin
  result := FsIDTeste;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
procedure TfpgCtrlProcessoParteFake.SetfpgIDTeste(const Value: string);
begin
  FsIDTeste := Value;
end;

// 28/11/2014 - rodrigo.db1 - SALT: 152429/1
function TfpgCtrlProcessoParteFake.PegarAutorizacaoComponente(
  const psnmComponente: string): boolean;
begin
  result := False;

  if FocdsPermissoes.Locate('nmComponente', psnmComponente, []) then
  begin
    result := FocdsPermissoes.FieldByName('flAutorizado').AsString = sFLAG_SIM;
  end;
end;

end.


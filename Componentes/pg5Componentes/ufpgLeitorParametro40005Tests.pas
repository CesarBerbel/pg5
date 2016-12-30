unit ufpgLeitorParametro40005Tests;

interface

uses
  ufpgLeitorParametro40005, TestFrameWork, ufpgGerenciadorParamSistema;

type
  TFakeGerenciadorParamSistema = class(TfpgGerenciadorParamSistema)
    FsValorParametro: string;
  public
    function AsString(ncdParametro: integer; ncdSistema: integer): string; override;
    property ValorParametro: string read FsValorParametro write FsValorParametro;
  end;

  TfpgLeitorParametro40005Tests = class(TTestCase)
  private
    FoLeitorParametro40005: TfpgLeitorParametro40005;
    FoFakeGerenciadorParamSistema: TFakeGerenciadorParamSistema;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // Test methods
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcessoParametroConfiguradoEmissao;
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcessoParametroConfiguradoCadastro;
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcessoParametroConfiguradoDistribuicao;

    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcessoParametroConfiguradoEmissao;
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcessoParametroConfiguradoCadastro;
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcessoParametroConfiguradoDistribuicao;

    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisaoParametroConfiguradoEmissao;
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisaoParametroConfiguradoCadastro;
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisaoParametroConfiguradoDistribuicao;

    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcessoParametroConfiguradoEmissao;
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcessoParametroConfiguradoCadastro;
    procedure TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcessoParametroConfiguradoDistribuicao;
  end;

implementation

uses
  SysUtils, usajConstante, uspParametro, usajParametros, ufpgParametro;

{ TfpgLeitorParametro40005Tests }

procedure TfpgLeitorParametro40005Tests.SetUp;
begin
  inherited;
  FoFakeGerenciadorParamSistema := TFakeGerenciadorParamSistema.Create; //PC_OK
  FoLeitorParametro40005 := TfpgLeitorParametro40005.Create; //PC_OK

  FoLeitorParametro40005.DefinirGerenciadorParamSistema(FoFakeGerenciadorParamSistema);
end;

procedure TfpgLeitorParametro40005Tests.TearDown;
begin
  inherited;
  FreeAndNil(FoLeitorParametro40005); //PC_OK
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcessoParametroConfiguradoEmissao;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sEMISSAO_MANDADO_PRISAO;
  CheckFalse(FoLeitorParametro40005.
    TestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcesso);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcessoParametroConfiguradoCadastro;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sCADASTRAMENTO_PROCESSO;
  CheckTrue(FoLeitorParametro40005.
    TestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcesso);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcessoParametroConfiguradoDistribuicao;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sDISTRIBUICAO_PROCESSO;
  CheckTrue(FoLeitorParametro40005.
    TestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoOuDistribuicaoDoProcesso);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisaoParametroConfiguradoCadastro;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sCADASTRAMENTO_PROCESSO;
  CheckFalse(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisao
    );
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisaoParametroConfiguradoDistribuicao;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sDISTRIBUICAO_PROCESSO;
  CheckFalse(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisao
    );
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisaoParametroConfiguradoEmissao;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sEMISSAO_MANDADO_PRISAO;
  CheckTrue(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNaEmissaoDeMandadoDePrisao);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcessoParametroConfiguradoCadastro;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sCADASTRAMENTO_PROCESSO;
  CheckFalse(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcesso);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcessoParametroConfiguradoDistribuicao;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sDISTRIBUICAO_PROCESSO;
  CheckTrue(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcesso);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcessoParametroConfiguradoEmissao;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sEMISSAO_MANDADO_PRISAO;
  CheckFalse(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNaDistribuicaoDoProcesso);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcessoParametroConfiguradoCadastro;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sCADASTRAMENTO_PROCESSO;
  CheckTrue(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcesso);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcessoParametroConfiguradoDistribuicao;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sDISTRIBUICAO_PROCESSO;
  CheckFalse(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcesso);
end;

procedure TfpgLeitorParametro40005Tests.
TestarTestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcessoParametroConfiguradoEmissao;
begin
  FoFakeGerenciadorParamSistema.ValorParametro := sEMISSAO_MANDADO_PRISAO;
  CheckFalse(FoLeitorParametro40005.TestarSeDadosDaDelegaciaSaoValidadosNoCadastramentoDoProcesso);
end;

{ TFakeGerenciadorParamSistema }

function TFakeGerenciadorParamSistema.AsString(ncdParametro, ncdSistema: integer): string;
begin
  result := STRING_INDEFINIDO;
  if not (ncdParametro = prmDistribuiSemDocDelegacia) then
    Exit;

  if not (ncdSistema = gnCdPrmPG5) then
    Exit;

  result := ValorParametro;
end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgLeitorParametro40005Tests',
    TfpgLeitorParametro40005Tests.Suite);

end.


unit ufpgValidadorTipoAcessoPetIntermediariaProcessoTests;

interface

uses
  TestFrameWork, Classes, ufpgValidadorTipoAcessoPetIntermediariaProcessoFake, DB, DBClient;

type
  TfpgValidadorTipoAcessoPetIntermediariaProcessoTests = class(TspTestCase)
  private
    FoValidadorTipoAcessoPetIntermediariaProcessoFake: TfpgValidadorTipoAcessoPetIntermediariaProcessoFake;
    FoDadosProcesso: TClientDataSet;
    procedure DefinirDataSetDadosProcesso;
    procedure AdicionarRegistroDadosProcesso(const psCdProcesso, pstpSigilo: string);

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published

    procedure TestarAcessoPermitidoMagistradoSigiloAbsoluto;

    procedure TestarAcessoSigiloExterno;

    procedure TestarAcessoSigiloExternoComFuncao;

    procedure TestarAcessoSigiloSemSigilo;

    procedure TestarAcessoSigiloSemSigiloComFuncao;

    procedure TestarAcessoSigiloAbsolutoMagNaoPermiteComFuncao;

    procedure TestarAcessoSigiloAbsolutoMagNaoPermiteSemFuncao;


  end;

implementation

uses
  SysUtils, uproConstante, usajConstante;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.SetUp;
begin
  FoValidadorTipoAcessoPetIntermediariaProcessoFake :=
    TfpgValidadorTipoAcessoPetIntermediariaProcessoFake.Create(null);
  DefinirDataSetDadosProcesso;
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.TearDown;
begin
  FreeAndNil(FoValidadorTipoAcessoPetIntermediariaProcessoFake);
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.
TestarAcessoPermitidoMagistradoSigiloAbsoluto;
begin
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgSigiloProcesso := sTPSIGILOABSOLUTO;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgUsuarioPossuiFuncaoSeg := False;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgAcessoPeloMagistrado := True;
  CheckTrue(FoValidadorTipoAcessoPetIntermediariaProcessoFake.
    PegarTipoVisualizacaoPeticaoIntermediaria('0100055XZXO') = sTP_ACESSO_PET_INTERM_ACESSA);
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.TestarAcessoSigiloExterno;
begin
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgSigiloProcesso := sTPSIGILOEXTERNO;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgUsuarioPossuiFuncaoSeg := False;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgAcessoPeloMagistrado := False;
  CheckTrue(FoValidadorTipoAcessoPetIntermediariaProcessoFake.
    PegarTipoVisualizacaoPeticaoIntermediaria('0100055XAAB') = sTP_ACESSO_PET_INTERM_ACESSA);
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.TestarAcessoSigiloExternoComFuncao;
begin
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgSigiloProcesso := sTPSIGILOEXTERNO;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgUsuarioPossuiFuncaoSeg := True;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgAcessoPeloMagistrado := False;
  CheckTrue(FoValidadorTipoAcessoPetIntermediariaProcessoFake.
    PegarTipoVisualizacaoPeticaoIntermediaria('0122055A99B') = sTP_ACESSO_PET_INTERM_ACESSA);
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.TestarAcessoSigiloSemSigilo;
begin
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgSigiloProcesso := sTPSIGILONENHUM;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgUsuarioPossuiFuncaoSeg := False;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgAcessoPeloMagistrado := False;
  CheckTrue(FoValidadorTipoAcessoPetIntermediariaProcessoFake.
    PegarTipoVisualizacaoPeticaoIntermediaria('0122055X878') = sTP_ACESSO_PET_INTERM_ACESSA);
end;


procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.
TestarAcessoSigiloSemSigiloComFuncao;
begin
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgSigiloProcesso := sTPSIGILONENHUM;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgUsuarioPossuiFuncaoSeg := True;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgAcessoPeloMagistrado := False;
  CheckTrue(FoValidadorTipoAcessoPetIntermediariaProcessoFake.
    PegarTipoVisualizacaoPeticaoIntermediaria('01227891878') = sTP_ACESSO_PET_INTERM_ACESSA);
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.
TestarAcessoSigiloAbsolutoMagNaoPermiteComFuncao;
begin
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgSigiloProcesso := sTPSIGILOABSOLUTO;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgUsuarioPossuiFuncaoSeg := True;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgAcessoPeloMagistrado := False;
  CheckTrue(FoValidadorTipoAcessoPetIntermediariaProcessoFake.
    PegarTipoVisualizacaoPeticaoIntermediaria('01FFAST1878') = sTP_ACESSO_PET_INTERM_QUESTIONA);
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.
TestarAcessoSigiloAbsolutoMagNaoPermiteSemFuncao;
begin
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgSigiloProcesso := sTPSIGILOABSOLUTO;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgUsuarioPossuiFuncaoSeg := False;
  FoValidadorTipoAcessoPetIntermediariaProcessoFake.fpgAcessoPeloMagistrado := False;
  CheckTrue(FoValidadorTipoAcessoPetIntermediariaProcessoFake.
    PegarTipoVisualizacaoPeticaoIntermediaria('01JJHGD1878') = sTP_ACESSO_PET_INTERM_NEGADO);
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.DefinirDataSetDadosProcesso;
begin
  FoDadosProcesso := TClientDataSet.Create(nil);
  FoDadosProcesso.fieldDefs.Add('cdProcesso', ftString, 20);
  FoDadosProcesso.fieldDefs.Add('tpSigilo', ftString, 1);
  FoDadosProcesso.createDataSet;
  FoDadosProcesso.Open;

  AdicionarRegistroDadosProcesso('0100055XZXO', sTPSIGILOABSOLUTO);
  AdicionarRegistroDadosProcesso('0100055XAAB', sTPSIGILOEXTERNO);
  AdicionarRegistroDadosProcesso('0122055A99B', sTPSIGILOEXTERNO);
  AdicionarRegistroDadosProcesso('0122055X878', sTPSIGILONENHUM);
  AdicionarRegistroDadosProcesso('01227891878', sTPSIGILONENHUM);
  AdicionarRegistroDadosProcesso('01FFAST1878', sTPSIGILOABSOLUTO);
  AdicionarRegistroDadosProcesso('01JJHGD1878', sTPSIGILOABSOLUTO);
end;

procedure TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.AdicionarRegistroDadosProcesso(
  const psCdProcesso, pstpSigilo: string);
begin
  FoDadosProcesso.append;
  FoDadosProcesso.FieldByName('cdProcesso').AsString := psCdProcesso;
  FoDadosProcesso.FieldByName('tpSigilo').AsString := pstpSigilo;
  FoDadosProcesso.post;
end;

initialization
  TestFrameWork.RegisterTest(
    'Unitário\PG5\Servidor\ufpgValidadorTipoAcessoPetIntermediariaProcessoTests',
    TfpgValidadorTipoAcessoPetIntermediariaProcessoTests.Suite);

end.

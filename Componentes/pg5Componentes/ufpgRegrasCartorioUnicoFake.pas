unit ufpgRegrasCartorioUnicoFake;

interface

uses
  ufpgAdapterLotacaoUnica, ufpgRegrasCartorioUnico, uspTestCase, usajLotacao,
  ufpgRegrasLotacaoUnificada,
  ufpgRegrasLotacaoUnificadaFake, usajProcessamento;

type
  TfpgRegrasCartorioUnicoFake = class(TfpgRegrasCartorioUnico)
  private
    FoRegrasLotacaoUnificada: TfpgRegrasLotacaoUnificada;
  protected
    procedure CarregarDataSetCartorios; override;
    function TestarUsuarioLotadoCartorio: boolean; override;
    function TestarFuncaoCartorioUnicoAutorizadaPerfilUsuario: boolean; override;
    function ConsultarVarasDosCartoriosUsuarioPossuiLotacao: olevariant; override;
    function PegarUsuarioLogado: string; override;
    function PegarSequencialDeLotacaoDoUsuario: integer; override;
    function TestarSistemaPermiteCartorioUnico: boolean; override;
    procedure ConsultarListasGruposUsuario; override;
    function ConfirmarDeveAlternarLotacao(const pnNuSeqLotacao: integer;
      penOrigemRegra: TfpgTipoOrigemRegra): boolean; override;
    function CriarControleLotacao: TfpgRegrasLotacaoUnificada; override;
    function ExibirProcessamentoAlternandoLotacao: TfsajProcessamento; override;
  public
    FsUsuario: string;
    FnNuSeqLotacao: integer;
    FncdForo: integer;
    FncdVara: integer;
    FbRespostaUsuarioTrocaLotacao: boolean;

    // class function PegarClasseCartorioUnico: TfpgAdapterLotacaoUnicaClass; override;

    constructor Create(pvSpDB: olevariant); override;

    procedure DefinirUtilizaCartorioUnico(pbValor: boolean);
    procedure DefinirControleLotacaoFake(poControleLotacaoFake: TfpgRegrasLotacaoUnificadaFake);

    function AlternarLotacao(const pnNuSeqLotacao: integer;
      penTipoRegraLotacaoUnica: TfpgTipoRegraLotacaoUnica;
      penOrigemRegra: TfpgTipoOrigemRegra = torProcesso): boolean; overload; override;

    property prpControleLotacao: TfpgRegrasLotacaoUnificada read FoRegrasLotacaoUnificada;
  end;

implementation

{ TfpgRegrasCartorioUnicoFake }

uses
  Classes, SysUtils, DB, DBClient, uspClientDataSet;

function TfpgRegrasCartorioUnicoFake.CriarControleLotacao: TfpgRegrasLotacaoUnificada;
begin
  result := TfpgRegrasLotacaoUnificadaFake.Create; //PC_OK
end;

function TfpgRegrasCartorioUnicoFake.ConsultarVarasDosCartoriosUsuarioPossuiLotacao: olevariant;
var
  cdsForoVara: TspClientDataSet;
begin
  cdsForoVara := TspClientDataSet.Create(nil);
  try
    cdsForoVara.FieldDefs.Add('CC_CDFORO', ftInteger);
    cdsForoVara.FieldDefs.Add('CC_CDVARA', ftInteger);
    cdsForoVara.FieldDefs.Add('NUSEQLOTACAO', ftInteger);
    cdsForoVara.FieldDefs.Add('CC_DECARTORIO', ftString, 40);
    cdsForoVara.FieldDefs.Add('CC_CDGRUPO', ftInteger);
    cdsForoVara.FieldDefs.Add('CC_CDGRUPOTITULAR', ftInteger);
    cdsForoVara.CreateDataSet;

    TspTestCase.AppendStringList(cdsForoVara, '1, 3, 5,1º_Cartorio, 1');
    TspTestCase.AppendStringList(cdsForoVara, '2, 82, 55,2º_Cartorio, 2');
    TspTestCase.AppendStringList(cdsForoVara, '3, 182, 4,3º_Cartorio, 3');
    TspTestCase.AppendStringList(cdsForoVara, '3, 1827, 7,4º_Cartorio, 4, 12');
    TspTestCase.AppendStringList(cdsForoVara, '23, 6500, 17,5º_Cartorio, 5, 13');
    TspTestCase.AppendStringList(cdsForoVara, '23, 500, 3,6º_Cartorio, 6');
    TspTestCase.AppendStringList(cdsForoVara, '23, 5, 44,7º_Cartorio, 7');
    TspTestCase.AppendStringList(cdsForoVara, '897, 15, 63,8º_Cartorio, 8');
    TspTestCase.AppendStringList(cdsForoVara, '874, 456, 45,9º_Cartorio, 9');
    TspTestCase.AppendStringList(cdsForoVara, '874, 7702, 91,10º_Cartorio, 10');
    TspTestCase.AppendStringList(cdsForoVara, '81, 1, 74,11º_Cartorio, 11');
    TspTestCase.AppendStringList(cdsForoVara, '23, 1, 1,14º_Cartorio, 14');
    TspTestCase.AppendStringList(cdsForoVara, '113, 1, 2,15º_Cartorio, 15');
    TspTestCase.AppendStringList(cdsForoVara, '666, 1, 3,16º_Cartorio, 16');

    result := cdsForoVara.Data;
  finally
    FreeAndNil(cdsForoVara);
  end;
end;

procedure TfpgRegrasCartorioUnicoFake.CarregarDataSetCartorios;
begin
  FcdsForoCartorio.FieldDefs.Add('CC_CDFORO', ftInteger);
  FcdsForoCartorio.FieldDefs.Add('CC_CDCARTORIO', ftInteger);
  FcdsForoCartorio.FieldDefs.Add('CC_NUSEQLOTACAO', ftInteger);
  FcdsForoCartorio.FieldDefs.Add('CC_CDGRUPO', ftInteger);
  FcdsForoCartorio.CreateDataSet;

  TspTestCase.AppendStringList(FcdsForoCartorio, '23, 5, 1, 17');
  TspTestCase.AppendStringList(FcdsForoCartorio, '23, 18, 3, 18');
  TspTestCase.AppendStringList(FcdsForoCartorio, '23, 17, 7, 19');
  TspTestCase.AppendStringList(FcdsForoCartorio, '42, 5, 1, 20');
  TspTestCase.AppendStringList(FcdsForoCartorio, '7, 9, 2, 66666');

  FcdsForoCartorio.IndexFieldNames := 'CC_CDFORO;CC_CDCARTORIO';
end;

function TfpgRegrasCartorioUnicoFake.TestarUsuarioLotadoCartorio: boolean;
begin
  result := True;
end;

function TfpgRegrasCartorioUnicoFake.TestarFuncaoCartorioUnicoAutorizadaPerfilUsuario: boolean;
begin
  result := True;
end;

constructor TfpgRegrasCartorioUnicoFake.Create(pvSpDB: olevariant);
begin
  inherited;
  FbUtilizaLotacaoUnificada := True;
end;

// class function TfpgRegrasCartorioUnicoFake.PegarClasseCartorioUnico: TfpgAdapterLotacaoUnicaClass;
// begin
//   result := TfpgRegrasCartorioUnicoFake;
// end;

procedure TfpgRegrasCartorioUnicoFake.DefinirUtilizaCartorioUnico(pbValor: boolean);
begin
  FbUtilizaLotacaoUnificada := pbValor;
end;

function TfpgRegrasCartorioUnicoFake.PegarUsuarioLogado: string;
begin
  result := FsUsuario;
end;

function TfpgRegrasCartorioUnicoFake.PegarSequencialDeLotacaoDoUsuario: integer;
begin
  result := FnNuSeqLotacao;
end;

function TfpgRegrasCartorioUnicoFake.TestarSistemaPermiteCartorioUnico: boolean;
begin
  result := True;
end;

procedure TfpgRegrasCartorioUnicoFake.DefinirControleLotacaoFake(
  poControleLotacaoFake: TfpgRegrasLotacaoUnificadaFake);
var
  oTemporario: TfpgRegrasLotacaoUnificadaFake;
begin
  oTemporario := TfpgRegrasLotacaoUnificadaFake(FoRegrasLotacaoUnificada);

  FoRegrasLotacaoUnificada := poControleLotacaoFake;

  FreeAndNil(oTemporario); //PC_OK
end;

procedure TfpgRegrasCartorioUnicoFake.ConsultarListasGruposUsuario;
begin
  PreencherListaCdGrupoUsuarios(FcdsForoCartorio.Data);
  PreencherListaCdGrupoUsuarios(FcdsForoVaras.Data);
end;

function TfpgRegrasCartorioUnicoFake.ConfirmarDeveAlternarLotacao(
  const pnNuSeqLotacao: integer; penOrigemRegra: TfpgTipoOrigemRegra): boolean;
begin
  result := FbRespostaUsuarioTrocaLotacao;
end;

function TfpgRegrasCartorioUnicoFake.AlternarLotacao(const pnNuSeqLotacao: integer;
  penTipoRegraLotacaoUnica: TfpgTipoRegraLotacaoUnica;
  penOrigemRegra: TfpgTipoOrigemRegra = torProcesso): boolean;
begin
  TfpgRegrasLotacaoUnificadaFake(prpControleLotacao).fpgNuSeqLotacao := pnNuSeqLotacao;

  result := inherited AlternarLotacao(pnNuSeqLotacao, penTipoRegraLotacaoUnica, penOrigemRegra);
end;

function TfpgRegrasCartorioUnicoFake.ExibirProcessamentoAlternandoLotacao: TfsajProcessamento;
begin
  result := nil;
end;

end.

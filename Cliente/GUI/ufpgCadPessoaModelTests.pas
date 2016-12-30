unit ufpgCadPessoaModelTests;

interface

uses
  ufpgCadPessoa, ufpgDataModelTests, ADODB, SysUtils, ufpgPessoaRepositorio,
  ufpgFuncoesSQLTests, ufpgFuncoesGUISQLTests, uspClientDataSet;

type
  TffpgCadPessoaModelTests = class(TfpgDataModelTests)
  private
    FsNomePessoa: string;
    FsTemOAB: boolean;
    FsTemCPF: boolean;
    FsTemCNPJ: boolean;
    FoPessoaRepositorio: TfpgPessoaRepositorio;
    FsOrgaoExpedidor: string;
    FsNomePessoaAlterado: string;
    FbAlteraDadosPessoas: boolean;
    FbAbrirDoMenu: boolean;
    FbCadastraPessoa: boolean;
    FbSomentePesquisa: boolean;
    FbGerarPessoa: boolean;
    FbTemEndereco: boolean;
    FsCep: string;
    FsLogradouro: string;
    FsBairro: string;
    FsNumero: string;
    FsFormaPgto: boolean;
    FsVerificarFuncSegAlteracao: boolean;
    FsCdPessoa: string;
    FsForaUso: boolean;
  public
    function GerarNumeroOAB: string;
    function GerarNumeroCPF: string;
    class function UsuarioPossuiFuncSeg(psUsuario: string): boolean;
    class function VerificaAlteracaoDadosPessoas(psNomePessoa, psOrgaoExp: string): boolean;
    class function VerificaCadastroPessoa(psNomePessoa, psCPFPessoa: string): boolean;
  published
    property fpgNomePessoa: string read FsNomePessoa write FsNomePessoa;
    property fpgTemOAB: boolean read FsTemOAB write FsTemOAB;
    property fpgTemCPF: boolean read FsTemCPF write FsTemCPF;
    property fpgTemCNPJ: boolean read FsTemCNPJ write FsTemCNPJ;
    property fpgOrgaoExpedidor: string read FsOrgaoExpedidor write FsOrgaoExpedidor;
    property fpgNomePessoaAlterado: string read FsNomePessoaAlterado write FsNomePessoaAlterado;
    property fpgPessoaRepositorio: TfpgPessoaRepositorio 
      read FoPessoaRepositorio   write FoPessoaRepositorio;
    property fpgAlteraDadosPessoas: boolean read FbAlteraDadosPessoas write FbAlteraDadosPessoas;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgCadastraPessoa: boolean read FbCadastraPessoa write FbCadastraPessoa;
    property fpgSomentePesquisa: boolean read FbSomentePesquisa write FbSomentePesquisa;
    property fpgGerarPessoa: boolean read FbGerarPessoa write FbGerarPessoa;
    property fpgTemEndereco: boolean read FbTemEndereco write FbTemEndereco;
    property fpgCep: string read FsCep write FsCep;
    property fpgLogradouro: string read FsLogradouro write FsLogradouro;
    property fpgNumero: string read FsNumero write FsNumero;
    property fpgCdPessoa: string read FsCdPessoa write FsCdPessoa;
    property fpgBairro: string read FsBairro write FsBairro;
    property fpgFormaPgto: boolean read FsFormaPgto write FsFormaPgto;
    property fpgForaUso: boolean read FsForaUso write FsForaUso;
    property fpgVerificarFuncSegAlteracao: boolean 
      read FsVerificarFuncSegAlteracao   write FsVerificarFuncSegAlteracao;
  end;

implementation

uses
  usegRepositorio;

{ TffpgCadPessoaModelTests }


function TffpgCadPessoaModelTests.GerarNumeroCPF: string;
var
  Procode9: array [1..9] of char;
  Procode1, Procode2: char;
  i, soma, d1, d2: integer;
begin
  for i := 1 to 9 do
    Procode9[i] := IntToStr(Random(9))[1];

  soma := 0;
  for i := 10 downto 2 do
    soma := soma + (i * StrToInt(Procode9[11 - i]));

  d1 := soma mod 11;

  if ((d1 = 0) or (d1 = 1)) then
    Procode1 := '0'
  else
    Procode1 := IntToStr(11 - d1)[1];

  soma := 0;
  for i := 11 downto 3 do
    soma := soma + (i * StrToInt(Procode9[12 - i]));

  soma := soma + (2 * StrToInt(Procode1));
  d2 := soma mod 11;
  if ((d2 = 0) or (d2 = 1)) then
    Procode2 := '0'
  else
    Procode2 := IntToStr(11 - d2)[1];

  result := string(Procode9 + Procode1 + Procode2);
end;

function TffpgCadPessoaModelTests.GerarNumeroOAB: string;
var
  n: integer;
  sOAB: string;
begin
  sOAB := '';
  for n := 1 to 6 do
    sOAB := sOAB + IntToStr(Random(9) + 1);
  result := sOAB + chr(Ord('A') + random(26)) + chr(Ord('A') + random(26));
end;

{ Data de Criação:  02/07/2015  Responsável: Shirleano.Junior  Salt: 186660/6/5}
class function TffpgCadPessoaModelTests.VerificaAlteracaoDadosPessoas(psNomePessoa: string;
  psOrgaoExp: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerifcarAlteracaoDadosPessoaSql(quotedstr(psNomePessoa), quotedstr(psOrgaoExp));
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadPessoaModelTests.VerificaCadastroPessoa(psNomePessoa,
  psCPFPessoa: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificaCadastroPessoaSql(quotedstr(psNomePessoa), quotedstr(psCPFPessoa));
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;

  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadPessoaModelTests.UsuarioPossuiFuncSeg(psUsuario: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarFuncaoSeguranca(psUsuario);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('AUTORIZADO').AsString <> '';
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


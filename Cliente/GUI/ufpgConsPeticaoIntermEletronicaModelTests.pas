unit ufpgConsPeticaoIntermEletronicaModelTests;

interface

uses
  SysUtils, ufpgDataModelTests, ufpgFuncoesSQLTests;

type
  TffpgConsPeticaoIntermEletronicaModelTests = class(TfpgDataModelTests)
  private
    FsClasse: string;
    FsCompetencia: string;
    FsAssunto: string;
    FsNomeParte: string;
    FsClasse1: string;
    FsClasse2: string;
    FsClasse3: string;
    FsClasse4: string;
    FsClasse5: string;
    FsCEP: string;
  published
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgAssunto: string read FsAssunto write FsAssunto;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgNomeParte: string read FsNomeParte write FsNomeParte;
    property fpgClasse1: string read FsClasse1 write FsClasse1;
    property fpgClasse2: string read FsClasse2 write FsClasse2;
    property fpgClasse3: string read FsClasse3 write FsClasse3;
    property fpgClasse4: string read FsClasse4 write FsClasse4;
    property fpgClasse5: string read FsClasse5 write FsClasse5;
    property fpgCEP: string read FsCEP write FsCEP;
    class function VerificarPeticaoCadastrada(psNuProcesso, psNuClasseProcesso: string): boolean;
    class function VerificarPeticaoIntermediaria(psNuProcesso: string): boolean;
    class function VerificarProcessoCancelado(psNuProcesso: string): boolean;
  end;

implementation

uses
  uSegRepositorio;

{ TfproConsPeticaoIntermEletronicaModelTests }

class function TffpgConsPeticaoIntermEletronicaModelTests.VerificarPeticaoCadastrada(
  psNuProcesso, psNuClasseProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarPeticaoCadastradaSql(psNuProcesso, psNuClasseProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('PETICAO').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//LUCIANO.FAGUNDES  - 17/07/2015 - SALT: 186660/8/8
class function TffpgConsPeticaoIntermEletronicaModelTests.VerificarPeticaoIntermediaria(
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarPeticaoIntermdiariaSql(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('VALIDADE').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//LUCIANO.FAGUNDES  - 17/07/2015 - SALT: 186660/8/8
class function TffpgConsPeticaoIntermEletronicaModelTests.VerificarProcessoCancelado(
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarProcessoCancelado(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.


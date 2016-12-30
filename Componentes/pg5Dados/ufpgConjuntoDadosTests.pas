unit ufpgConjuntoDadosTests;

interface

uses
  TestFramework, uspConjuntoDadosTests;

type
  TfpgValidarClasseTestes = class(TspValidarClasseTestes)
  public
    procedure PopularClassesIgnoradas; override;
    class function GetClassValidarTestes: TspValidarClasseTestesClass; override;
  end;


implementation

{ TspjConjuntoDadosTest }
class function TfpgValidarClasseTestes.GetClassValidarTestes: TspValidarClasseTestesClass;
begin
  result := TfpgValidarClasseTestes;
end;

procedure TfpgValidarClasseTestes.PopularClassesIgnoradas;
begin
  inherited PopularClassesIgnoradas;

  FListaClassesIgnorar.Add('TefpgEstMovJudCivel');
  FListaClassesIgnorar.Add('TesajAgente');
  FListaClassesIgnorar.Add('TepadValorParametro');
  FListaClassesIgnorar.Add('TesajClasse');
  FListaClassesIgnorar.Add('TesajClasseTarja');
  FListaClassesIgnorar.Add('TesajForo');
  FListaClassesIgnorar.Add('TesajLocal');
  FListaClassesIgnorar.Add('TesajPessoa');
  FListaClassesIgnorar.Add('TesajProcesso');
  FListaClassesIgnorar.Add('TesajTipoEvento');
  FListaClassesIgnorar.Add('TesajTipoLocal');
  FListaClassesIgnorar.Add('TesajTipoParte');
  FListaClassesIgnorar.Add('TesajVara');
  FListaClassesIgnorar.Add('TesajVaraEquiv');
  FListaClassesIgnorar.Add('TesegAutorizGrupo');
  FListaClassesIgnorar.Add('TesegAutUsuario');
  FListaClassesIgnorar.Add('TesegCertificado');
end;

initialization
  oValidarClassesCreate(TfpgValidarClasseTestes);

finalization
  oValidarClassesFree;

end.


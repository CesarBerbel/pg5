// 09/11/2016  - Carlos.Gaspar - TASK: 67185
// 09/11/2016  - Yuri.Fernandes - TASK: 67185
unit ufpgAjudaModelTests;

interface

uses
  ufpgModelTests, SysUtils;

type
  TffpgAjudaModelTests = class(TfpgModelTests)
  private
    FsNuProcessoUnificar: string;
    FsNuProcessoPrinc: string;
    FsRegistraMsgPartes: boolean;
  published
    property fpgNuProcessoPrinc: string read FsNuProcessoPrinc write FsNuProcessoPrinc;
    property fpgNuProcessoUnificar: string read FsNuProcessoUnificar write FsNuProcessoUnificar;
    property fpgRegistraMsgPartes: boolean read FsRegistraMsgPartes write FsRegistraMsgPartes;
  end;

implementation


end.


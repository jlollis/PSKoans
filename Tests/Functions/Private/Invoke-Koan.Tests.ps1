﻿using module PSKoans

InModuleScope 'PSKoans' {
    Describe 'Invoke-Koan' {
        BeforeAll {
            $TestFile = "$script:ModuleFolder\..\Tests\DummyKoans\Invoke-Koan.Control_Tests.ps1"
        }

        It 'will not error out' {
            {
                Invoke-Koan -Script $TestFile
            } | Should -Not -Throw
        }

        It 'will produce output with -Passthru' {
            Invoke-Koan -Script $TestFile -PassThru | Should -Not -BeNullOrEmpty
        }

        It 'will correctly report test results' {
            $Results = Invoke-Koan -Script $TestFile -PassThru

            $Results.TotalCount | Should -Be 2
            $Results.PassedCount | Should -Be 0
            $Results.FailedCount | Should -Be 2
        }

        It 'reports only expected exception types' {
            $Results = Invoke-Koan -Script $TestFile -PassThru

            $Results.TestResult.ErrorRecord.Exception |
                ForEach-Object -MemberName GetType |
                Should -Be @([Exception], [NotImplementedException])
        }
    }
}
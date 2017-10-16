# sudo is only set if sudoers recipe is run, this recipe also evaluates the :sudo parameter to decide if it should add the users to sudoers
default['sshusers']['users'] =
[
    {
        :name => 'simon.buxton',
        :sudo => true,
        :ssh_public_keys => ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGFQuEvA/HBsx9Hr1yRfDP2VkuKYPhU9L7Vcxa5ytCVTi32ujiSCyAJnS89LeX5UVz2v5ZGozLL4kag9KakAkOyl2Sxo2mnkb+cnsm5woAAVrRoR5741Vu+UOX0KnOMBIDG8+BwzhGivF74gREHcvzWiJz+wOzuaFQ53sVAMhWjWi27JEYmRREpKDedadXV1cSSuWyyaidZf3BxKbY05qmY5S7TEJWKDOVdIeHhapUNVHP1d8HVIBnFOTdO4LMaUfFHcnLOzNm9Q6nnceVr7JKjkn/CV+yusiVH9pkx4lv8oITdDCyNv2OiO7hvejlZDvmzHx7xqRPDu66ZRevCqe/ simon.buxton@SimonB-MacBook-Pro.local']
    },
    {
        :name => 'adam.bidwell',
        :sudo => true,
        :ssh_public_keys => ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlFOR8V9cFmm5uxuVrPksXil04HGmFg3/xhRAgpgsdbFCQhjZsDURWQwL12kmxuRv9VfN+8RHB0rDQYe9AnEq5DX/MOpx125shPLqm1uQQZRmHQ+3KNgVhkFRo8Q5ay1brs+X6JWWip1X0jniOy5VRc/Ni8+Xk2FvBUxVG0lj1HLfQ/vfsg0IVO8r3hNgJhgtlYJCURgybHzNkrzfY+9gZPzkVN3qhuIL4hnvO1SRXNAjtKym/sTbZGKKXYlbFUD29bPt3ULZ+qnV/C1l0E4WGwS4LOU+/V1U3c/2X/fvAAhc7tWZqOzwTPzXVZ+d0T0Vtm5eHvzQP0UwvPi1j0oCr adam.bidwell@adambidwell.devbox.kg']
    },
    {
        :name => 'justin.hogg',
        :sudo => true,
        :ssh_public_keys => ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUE2Ed4T41DzoYm5QBkk8vaiqypUQtMgVAZ2g6pEQFS5CAzB2jb06L5Yun56x6yjj8+BviXnuV2FnQT8vl+grBCo0zHPenGK7WRjLKCYQCU1wTiGKu+0GFy6/3i3f0eoWpgGVpH/I6Qj/X8WF2y5PCfGvAbx3Tr68ZQAj0cn6Aegi9iINWhX7ek1/VgqWKA4bC6GSMD1oqm2cwLfXz/usVUNvUo3U9jcBijC4gtAwLtdE49L8XD7PTa68ronJ+/gLJFahStOqZOg8io8LxdxRMrMMpSv+sykEeuu8F795j/lvQYHpGk/tIAsjJ59rYQMToyD116Pp6UPZxQwJ1yfAH justin.hogg@johns-MacBook-Pro.local']
    },
    {
        :name => 'ajeesh.george',
        :sudo => true,
        :ssh_public_keys => ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNqRTsFYVGDcIMtO6Fft55ygdk5WXZhx2Ti6iqIQbvnGrVwiCyaMyEsdLfBvpTaoZ+4OHGLDvvdvS7OCFSPL5jCT9oBzuiizxeU9UYJKn1fd4dtoJI+DJllJh/ocs/gLMK4ixeEtIDPbWaUDTd1LEhuNPiKXi4HzWd3GY5xZU55lhoQ/hi5B62deYp8ifHpSEghcCfWufitVLCE/B+BUsFqinMouOJc2CzH7VpCz3E1GOtfO2ROQqUXLPLNwT5Sn4rPYx+vdeGf37yK0RTH/ZX/0aL+HkIlPZjY2B+z0czwjttjGieq++ZE+ek9Q2N9W4eYx3v0CevVvTaqU+rt5xV ajeesh.george@ajeeshg.devbox.kg']
    }
]

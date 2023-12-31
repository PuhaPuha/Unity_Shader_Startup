Shader "Custom/14-03"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap ("NormalMap", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Toon noambient
        
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BumpMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Alpha = c.a;
        }

        float4 LightingToon (SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
        {
            float ndotl = dot(s.Normal, lightDir) * 0.5 + 0.5;
            if (ndotl > 0.7)
                ndotl = 1;
            else if (ndotl > 0.4)
            {
                ndotl = 0.3;
            }
            else
            {
                ndotl = 0;
            }

            float rim = abs(dot(s.Normal,viewDir));
            if (rim > 0.3)
            {
                rim = 1;
            }

            else
            {
                rim = -1;
            }
            
            float4 final;
            final.rgb=ndotl * s.Albedo * _LightColor0.rgb * rim;
            final.a = s.Alpha;
            
            return final;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

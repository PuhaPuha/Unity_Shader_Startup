Shader "Custom/14-03"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        
        cull front

        CGPROGRAM
        #pragma surface surf Lambert
        
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
        
//        // 2nd Pass
//        CGPROGRAM
//        #pragma surface surf Lambert
//        
//        #pragma target 3.0
//
//        sampler2D _MainTex;
//
//        struct Input
//        {
//            float2 uv_MainTex;
//        };
//
//        void surf (Input IN, inout SurfaceOutput o)
//        {
//            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
//            o.Albedo = c.rgb;
//            o.Alpha = c.a;
//        }
//        ENDCG
    }
    FallBack "Diffuse"
}
